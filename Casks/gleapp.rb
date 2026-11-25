cask "gleapp" do
  version "v2026.5.8"

  if Hardware::CPU.intel?
    url "https://github.com/abrignoni/GLEAPP/releases/download/v2026.5.8/GLEAPP-2026.5.8-macos-x64.dmg"
    sha256 "c74bf2ceb655d9c0742f23f7a4453fa4ae0b72cb45f6e07cb6790683bdc78b40"
  else
    url "https://github.com/abrignoni/GLEAPP/releases/download/v2026.5.8/GLEAPP-2026.5.8-macos-arm64.dmg"
    sha256 "8badb58b90126ac317b63c79e794769c51411c498814223fe4f05370f3e7d5ae"
  end

  name "GLEAPP"
  desc "Image and video forensic triage toolkit"
  homepage "https://github.com/abrignoni/GLEAPP"

  app "GLEAPP.app"
  binary "#{appdir}/GLEAPP.app/Contents/MacOS/GLEAPP", target: "gleapp"
end
