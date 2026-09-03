cask "vleapp-gui" do
  version "v2026.3.2"

  if Hardware::CPU.intel?
    url "https://github.com/abrignoni/VLEAPP/releases/download/v2026.3.2/vleappGUI-v2026.3.2-macOS_Mac_Intel.dmg"
    sha256 "ecf18f77c72cc87559eb51853473781007946cc701becd3ff1f2c2aa813ac870"
  else
    url "https://github.com/abrignoni/VLEAPP/releases/download/v2026.3.2/vleappGUI-v2026.3.2-macOS_Apple_Silicon.dmg"
    sha256 "34719dfb5d2dae65e0e05762417c3b92573b4cad06295294dfe6d9d32a9f1553"
  end

  name "VLEAPP GUI"
  desc "Digital forensics tool for analyzing vehicle infotainment system artifacts with graphical interface"
  homepage "https://github.com/abrignoni/VLEAPP"

  app "vleappGUI.app"
end
