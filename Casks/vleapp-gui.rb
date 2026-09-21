cask "vleapp-gui" do
  version "v2026.4.1"

  if Hardware::CPU.intel?
    url "https://github.com/abrignoni/VLEAPP/releases/download/v2026.4.1/vleappGUI-v2026.4.1-macOS_Mac_Intel.dmg"
    sha256 "1c87af209ec688e3ecebebd553efd398932885dec5f116ea004f9b37f0f05eb0"
  else
    url "https://github.com/abrignoni/VLEAPP/releases/download/v2026.4.1/vleappGUI-v2026.4.1-macOS_Apple_Silicon.dmg"
    sha256 "dff02cd11df144ed9370324d7b10362b036a9af4777f1ac4ea91f551bb5c18f6"
  end

  name "VLEAPP GUI"
  desc "Digital forensics tool for analyzing vehicle infotainment system artifacts with graphical interface"
  homepage "https://github.com/abrignoni/VLEAPP"

  app "vleappGUI.app"
end
