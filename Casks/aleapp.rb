cask "aleapp" do
  version "v2026.5.0"

  if Hardware::CPU.intel?
    url "https://github.com/abrignoni/ALEAPP/releases/download/v2026.5.0/ALEAPP-2026.5.0-macos-x64.dmg"
    sha256 "4a687895b57ea2ba6adbabe252f5164d3859b1c2da4cfaa8973d5719a280c75a"
  else
    url "https://github.com/abrignoni/ALEAPP/releases/download/v2026.5.0/ALEAPP-2026.5.0-macos-arm64.dmg"
    sha256 "de3505f30a10d49b4ce90f496e7b0de347a02152ed0e1eb3e613f3f0e4b2268b"
  end

  name "ALEAPP"
  desc "Digital forensics tool for parsing Android backup files, images, and artifacts"
  homepage "https://github.com/abrignoni/ALEAPP"

  app "ALEAPP.app"
  binary "#{appdir}/ALEAPP.app/Contents/MacOS/aleapp"
end
