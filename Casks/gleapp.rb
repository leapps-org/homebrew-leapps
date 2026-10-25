cask "gleapp" do
  version "v2026.5.5"

  if Hardware::CPU.intel?
    url "https://github.com/abrignoni/GLEAPP/releases/download/v2026.5.5/GLEAPP-2026.5.5-macos-x64.dmg"
    sha256 "76f6ef5f0a78f248949167466133f8c1754a9765a3f6e38f96c22fc86bc51981"
  else
    url "https://github.com/abrignoni/GLEAPP/releases/download/v2026.5.5/GLEAPP-2026.5.5-macos-arm64.dmg"
    sha256 "19808e38235e7a0281e88eb7284898cc526fca330c9beebb26e296771f1bd960"
  end

  name "GLEAPP"
  desc "Image and video forensic triage toolkit"
  homepage "https://github.com/abrignoni/GLEAPP"

  app "GLEAPP.app"
end
