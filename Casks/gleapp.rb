cask "gleapp" do
  version "v2026.5.7"

  if Hardware::CPU.intel?
    url "https://github.com/abrignoni/GLEAPP/releases/download/v2026.5.7/GLEAPP-2026.5.7-macos-x64.dmg"
    sha256 "9ac98e9e3c91cc343048b61ed1a767fbd543dd37cb725a8cff79c14941d5b2e9"
  else
    url "https://github.com/abrignoni/GLEAPP/releases/download/v2026.5.7/GLEAPP-2026.5.7-macos-arm64.dmg"
    sha256 "9d6a098306472921ae88e8d6722faaa8409c88f5930372659735dd7c23ebde0e"
  end

  name "GLEAPP"
  desc "Image and video forensic triage toolkit"
  homepage "https://github.com/abrignoni/GLEAPP"

  app "GLEAPP.app"
  binary "#{appdir}/GLEAPP.app/Contents/MacOS/GLEAPP", target: "gleapp"
end
