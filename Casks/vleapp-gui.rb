cask "vleapp-gui" do
  version "v2026.4.0"

  if Hardware::CPU.intel?
    url "https://github.com/abrignoni/VLEAPP/releases/download/v2026.4.0/vleappGUI-v2026.4.0-macOS_Mac_Intel.dmg"
    sha256 "3ca2f523f39063c53ad48b1c243f5e4e9ddc1d2d64909433090e8c0ae62f9601"
  else
    url "https://github.com/abrignoni/VLEAPP/releases/download/v2026.4.0/vleappGUI-v2026.4.0-macOS_Apple_Silicon.dmg"
    sha256 "18583b12b65b64d1a60a20897bb26cf6ba23b7c8d16d1dc2c816f57abbf0407d"
  end

  name "VLEAPP GUI"
  desc "Digital forensics tool for analyzing vehicle infotainment system artifacts with graphical interface"
  homepage "https://github.com/abrignoni/VLEAPP"

  app "vleappGUI.app"
end
