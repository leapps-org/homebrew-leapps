import test from 'node:test';
import assert from 'node:assert/strict';
import { readFile } from 'node:fs/promises';
import { assetName, renderCask } from './update-casks.mjs';

const root = new URL('../', import.meta.url);
const loadJSON = async name => JSON.parse(await readFile(new URL(name, root), 'utf8'));
const { tools } = await loadJSON('tools.json');
const template = await readFile(new URL('templates/cask_template.rb', root), 'utf8');

function releaseFor(tool) {
  const tag_name = 'v2026.4.6';
  return {
    tag_name,
    assets: ['gui_intel_asset', 'gui_arm_asset'].map((field, index) => ({
      name: assetName(tool[field], tool, tag_name),
      browser_download_url: `https://example.com/${index}.dmg`,
      digest: `sha256:${String(index).repeat(64)}`,
    })),
  };
}

test('all combined casks link their CLI from the configured app directory', async () => {
  for (const tool of tools.filter(tool => tool.binary)) {
    const result = await renderCask(tool, releaseFor(tool), template);
    assert.ok(result.includes(`cask "${tool.name}" do`));
    assert.ok(result.includes(`binary "#{appdir}/${tool.app_bundle}.app/Contents/MacOS/${tool.binary_executable ?? tool.binary}"`));
    if (tool.binary_executable) assert.ok(result.includes(`target: "${tool.binary}"`));
    assert.ok(result.includes(`sha256 "${'0'.repeat(64)}"`));
    assert.ok(result.includes(`sha256 "${'1'.repeat(64)}"`));
    assert.ok(!result.includes('{{'));
  }
});

test('LAVA keeps its asset naming and does not acquire a CLI link', async () => {
  const tool = tools.find(tool => tool.name === 'lava');
  const release = releaseFor(tool);
  assert.equal(release.assets[0].name, 'LAVA-2026.4.6-macOS-Mac_Intel.dmg');
  const result = await renderCask(tool, release, template);
  assert.ok(result.includes('app "LAVA.app"'));
  assert.ok(!result.includes('binary '));
  const windowsResult = await renderCask(tool, release, template.replace(/\r?\n/g, '\r\n'));
  assert.equal(windowsResult, result);
  assert.ok(!result.includes('\n\nend'));
});

test('missing Intel or ARM assets fail instead of silently skipping a release', async () => {
  for (const index of [0, 1]) {
    const release = releaseFor(tools[0]);
    release.assets.splice(index, 1);
    await assert.rejects(renderCask(tools[0], release, template), /missing release asset/);
  }
});

test('missing digests use the checksum fallback for each architecture', async () => {
  const release = releaseFor(tools[0]);
  release.assets.forEach(asset => { delete asset.digest; });
  const calls = [];
  const result = await renderCask(tools[0], release, template, async asset => {
    calls.push(asset.name);
    return 'a'.repeat(64);
  });
  assert.equal(calls.length, 2);
  assert.equal((result.match(/sha256 "a{64}"/g) ?? []).length, 2);
});

test('formula migrations and GUI renames resolve to real plain-name casks', async () => {
  const migrations = await loadJSON('tap_migrations.json');
  const renames = await loadJSON('cask_renames.json');
  for (const tool of tools.filter(tool => tool.name in migrations)) {
    assert.equal(migrations[tool.name], `leapps-org/leapps/${tool.name}`);
    assert.equal(renames[`${tool.name}-gui`], tool.name);
    const cask = await readFile(new URL(`Casks/${tool.name}.rb`, root), 'utf8');
    assert.ok(cask.includes(`cask "${tool.name}" do`));
    assert.ok(cask.includes(`binary "#{appdir}/${tool.app_bundle}.app/Contents/MacOS/${tool.binary}"`));
  }
});
