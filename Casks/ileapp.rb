cask "ileapp" do
  version "v2026.4.7"

  if Hardware::CPU.intel?
    url "https://github.com/abrignoni/iLEAPP/releases/download/v2026.4.7/iLEAPP-2026.4.7-macos-x64.dmg"
    sha256 "040bd61aeed71b851e907f3dd0ee7c8061a08113aa4391a9162a9b06ad191c6e"
  else
    url "https://github.com/abrignoni/iLEAPP/releases/download/v2026.4.7/iLEAPP-2026.4.7-macos-arm64.dmg"
    sha256 "3743f4f5892364fef5fec8c96e52b5930a084b2807c67028effb863bc5c687e7"
  end

  name "iLEAPP"
  desc "Digital forensics tool for parsing iOS backup files, images, and artifacts"
  homepage "https://github.com/abrignoni/iLEAPP"

  app "iLEAPP.app"
  binary "#{appdir}/iLEAPP.app/Contents/MacOS/ileapp"
end
