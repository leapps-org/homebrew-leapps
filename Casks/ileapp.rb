cask "ileapp" do
  version "v2026.4.6"

  if Hardware::CPU.intel?
    url "https://github.com/abrignoni/iLEAPP/releases/download/v2026.4.6/iLEAPP-2026.4.6-macos-x64.dmg"
    sha256 "0af53df8bf172cbacf9ab8d88ab5b98f31d6f45352764e13bf6f54ea7412f81f"
  else
    url "https://github.com/abrignoni/iLEAPP/releases/download/v2026.4.6/iLEAPP-2026.4.6-macos-arm64.dmg"
    sha256 "c8a0632ceab3479238475fc43c25ac138875ad2bcbf13ba399b7e4c6d8257682"
  end

  name "iLEAPP"
  desc "Digital forensics tool for parsing iOS backup files, images, and artifacts"
  homepage "https://github.com/abrignoni/iLEAPP"

  app "iLEAPP.app"
  binary "#{appdir}/iLEAPP.app/Contents/MacOS/ileapp"
end
