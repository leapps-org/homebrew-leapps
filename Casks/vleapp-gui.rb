cask "vleapp-gui" do
  version "v2026.4.2"

  if Hardware::CPU.intel?
    url "https://github.com/abrignoni/VLEAPP/releases/download/v2026.4.2/VLEAPP-2026.4.2-macos-x64.dmg"
    sha256 "6718aba828a5f595c6c120ea646996a9ba1543846c601c28849967e661b01eca"
  else
    url "https://github.com/abrignoni/VLEAPP/releases/download/v2026.4.2/VLEAPP-2026.4.2-macos-arm64.dmg"
    sha256 "b361540dd53d2e450422d1b60f351cae08e4572833fe1afd31a8a73cb782cebf"
  end

  name "VLEAPP"
  desc "Digital forensics tool for analyzing vehicle infotainment system artifacts"
  homepage "https://github.com/abrignoni/VLEAPP"

  app "VLEAPP.app"
  binary "#{appdir}/VLEAPP.app/Contents/MacOS/vleapp"
end
