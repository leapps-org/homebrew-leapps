cask "gleapp" do
  version "v2026.5.4"

  if Hardware::CPU.intel?
    url "https://github.com/abrignoni/GLEAPP/releases/download/v2026.5.4/GLEAPP-2026.5.4-macos-x64.dmg"
    sha256 "e08fc4abd9d70f31d9a873a5d335c989dec383510481d1309a0cc6fc0d0b472e"
  else
    url "https://github.com/abrignoni/GLEAPP/releases/download/v2026.5.4/GLEAPP-2026.5.4-macos-arm64.dmg"
    sha256 "110d5ef2bcadccb94c0c7262e1eda801c844c1e74e721cd6d6e06609d068e8ea"
  end

  name "GLEAPP"
  desc "Image and video forensic triage toolkit"
  homepage "https://github.com/abrignoni/GLEAPP"

  app "GLEAPP.app"
end
