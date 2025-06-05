cask "vleapp-gui" do
  version "v2.1.2"

  if Hardware::CPU.intel?
    url "https://github.com/abrignoni/VLEAPP/releases/download/v2.1.2/vleappGUI-2.1.2-Mac_Intel.dmg"
    sha256 "5529b588c12cb17fb93630103ac7ff9c4b3c4c39b886dadb4463436d602da13c"
  else
    url "https://github.com/abrignoni/VLEAPP/releases/download/v2.1.2/vleappGUI-2.1.2-Apple_Silicon.dmg"
    sha256 "7b83546f422068fe7e86e4788b509cf5a674e2e69d5b20212d329725b0812c6e"
  end

  name "VLEAPP GUI"
  desc "Digital forensics tool for analyzing vehicle infotainment system artifacts with graphical interface"
  homepage "https://github.com/abrignoni/VLEAPP"

  app "vleappGUI.app"
end
