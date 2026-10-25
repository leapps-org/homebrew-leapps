cask "ileapp-gui" do
  version "v2026.4.5"

  if Hardware::CPU.intel?
    url "https://github.com/abrignoni/iLEAPP/releases/download/v2026.4.5/iLEAPP-2026.4.5-macos-x64.dmg"
    sha256 "741fc5f50d8006d2c05609f10c6ea420542c9b304b884c925032759f40f370a6"
  else
    url "https://github.com/abrignoni/iLEAPP/releases/download/v2026.4.5/iLEAPP-2026.4.5-macos-arm64.dmg"
    sha256 "5e932b703fe1d3bce260daa62087f1cfcb9ecfa20293add6ac483a29b3ba62c2"
  end

  name "iLEAPP"
  desc "Digital forensics tool for analyzing iOS artifacts"
  homepage "https://github.com/abrignoni/iLEAPP"

  app "iLEAPP.app"
  binary "#{appdir}/iLEAPP.app/Contents/MacOS/ileapp"
end
