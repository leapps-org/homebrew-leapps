cask "vleapp-gui" do
  version "v2026.4.3"

  if Hardware::CPU.intel?
    url "https://github.com/abrignoni/VLEAPP/releases/download/v2026.4.3/VLEAPP-2026.4.3-macos-x64.dmg"
    sha256 "64e7996ac7efc04d493dfb3668ade41eeaa0e66a8c4e751fbe74b9cd73908370"
  else
    url "https://github.com/abrignoni/VLEAPP/releases/download/v2026.4.3/VLEAPP-2026.4.3-macos-arm64.dmg"
    sha256 "7e0ebcc05040778c36038e9adebfdd8a49aa1b496034930ea204d5b8e29301c3"
  end

  name "VLEAPP"
  desc "Digital forensics tool for analyzing vehicle infotainment system artifacts"
  homepage "https://github.com/abrignoni/VLEAPP"

  app "VLEAPP.app"
  binary "#{appdir}/VLEAPP.app/Contents/MacOS/vleapp"
end
