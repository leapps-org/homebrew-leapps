import { readFile, writeFile } from 'node:fs/promises';
import { createHash } from 'node:crypto';
import { fileURLToPath } from 'node:url';
import path from 'node:path';

const root = fileURLToPath(new URL('../', import.meta.url));

async function request(url, api = false) {
  const headers = { 'User-Agent': 'homebrew-leapps-updater' };
  if (api && process.env.GITHUB_TOKEN) headers.Authorization = `Bearer ${process.env.GITHUB_TOKEN}`;
  const response = await fetch(url, { headers });
  if (!response.ok) throw new Error(`${url}: HTTP ${response.status}`);
  return response;
}

export function assetName(template, tool, tag) {
  return template.replaceAll('{{name}}', tool.name)
    .replaceAll('{{version}}', tag).replaceAll('{{version_no_v}}', tag.replace(/^v/, ''));
}

export async function renderCask(tool, release, template, checksum = assetChecksum) {
  if (!release.tag_name) throw new Error(`${tool.name}: missing release tag`);
  const assets = ['gui_intel_asset', 'gui_arm_asset'].map(field => {
    const name = assetName(tool[field], tool, release.tag_name);
    const asset = release.assets.find(item => item.name === name);
    if (!asset) throw new Error(`${tool.name}: missing release asset ${name}`);
    return asset;
  });
  const [intelSHA, armSHA] = await Promise.all(assets.map(checksum));
  const values = {
    cask_name: tool.cask_name, version: release.tag_name,
    gui_intel_url: assets[0].browser_download_url, gui_arm_url: assets[1].browser_download_url,
    gui_intel_sha: intelSHA, gui_arm_sha: armSHA,
    app_name: tool.app_name, desc_gui: tool.desc_gui, homepage: tool.repo,
    app_bundle: tool.app_bundle,
    binary_stanza: tool.binary
      ? `  binary "#{appdir}/${tool.app_bundle}.app/Contents/MacOS/${tool.binary_executable ?? tool.binary}"`
        + (tool.binary_executable ? `, target: "${tool.binary}"` : '') : '',
  };
  return template.replace(/\r\n/g, '\n').replace(/{{(\w+)}}/g, (_, key) => {
    if (!(key in values)) throw new Error(`Unknown template field: ${key}`);
    return values[key];
  }).replace(/\n\nend\n$/, '\nend\n');
}

async function assetChecksum(asset) {
  if (/^sha256:[a-f0-9]{64}$/.test(asset.digest ?? '')) return asset.digest.slice(7);
  const response = await request(asset.browser_download_url);
  const hash = createHash('sha256');
  for await (const chunk of response.body) hash.update(chunk);
  return hash.digest('hex');
}

async function main() {
  const { tools } = JSON.parse(await readFile(path.join(root, 'tools.json'), 'utf8'));
  const template = await readFile(path.join(root, 'templates/cask_template.rb'), 'utf8');
  // Validate every release before writing any files, so missing assets fail the job.
  const updates = [];
  for (const tool of tools) {
    const repo = tool.repo.replace('https://github.com/', '').replace(/\/$/, '');
    const release = await (await request(`https://api.github.com/repos/${repo}/releases/latest`, true)).json();
    updates.push([path.join(root, 'Casks', `${tool.cask_name}.rb`), await renderCask(tool, release, template)]);
    console.log(`${tool.name}: ${release.tag_name}`);
  }
  for (const [filename, content] of updates) await writeFile(filename, content);
}

if (process.argv[1] && path.resolve(process.argv[1]) === fileURLToPath(import.meta.url)) {
  main().catch(error => { console.error(error); process.exitCode = 1; });
}
