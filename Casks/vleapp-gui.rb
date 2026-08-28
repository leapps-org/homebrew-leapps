cask "vleapp-gui" do
  version "v2026.3.1"

  if Hardware::CPU.intel?
    url "https://github.com/abrignoni/VLEAPP/releases/download/v2026.3.1/vleappGUI-v2026.3.1-macOS_Mac_Intel.dmg"
    sha256 "6040b5f1d16f8d7fcd2d7cc1d13879515b8c5d62dd9afc1fefe54882c7fb0a36"
  else
    url "https://github.com/abrignoni/VLEAPP/releases/download/v2026.3.1/vleappGUI-v2026.3.1-macOS_Apple_Silicon.dmg"
    sha256 "817f1e6ce81232218fd0edf0cfa66636a91c395148522d8f2f28d1d48abe147a"
  end

  name "VLEAPP GUI"
  desc "Digital forensics tool for analyzing vehicle infotainment system artifacts with graphical interface"
  homepage "https://github.com/abrignoni/VLEAPP"

  app "vleappGUI.app"
end
