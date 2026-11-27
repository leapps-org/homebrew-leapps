cask "ileapp" do
  version "v2026.5.0"

  if Hardware::CPU.intel?
    url "https://github.com/abrignoni/iLEAPP/releases/download/v2026.5.0/iLEAPP-2026.5.0-macos-x64.dmg"
    sha256 "4bdbe85e9efe212dce35f443e4106c4378b734caa655cbc03a6422e1379b3e86"
  else
    url "https://github.com/abrignoni/iLEAPP/releases/download/v2026.5.0/iLEAPP-2026.5.0-macos-arm64.dmg"
    sha256 "1eb313cbe7a211c4770bb710178a6124dc2f2d42c8a81edd2d1d52fac92854c4"
  end

  name "iLEAPP"
  desc "Digital forensics tool for parsing iOS backup files, images, and artifacts"
  homepage "https://github.com/abrignoni/iLEAPP"

  app "iLEAPP.app"
  binary "#{appdir}/iLEAPP.app/Contents/MacOS/ileapp"
end
