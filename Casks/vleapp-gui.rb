cask "vleapp-gui" do
  version "v2.2.0"

  if Hardware::CPU.intel?
    url "https://github.com/abrignoni/VLEAPP/releases/download/v2.2.0/vleappGUI-v2.2.0-macOS_Mac_Intel.dmg"
    sha256 "bc5bb48c603be85f16080ca2a26883168bc576867f497d5f5b0913fb3da62c39"
  else
    url "https://github.com/abrignoni/VLEAPP/releases/download/v2.2.0/vleappGUI-v2.2.0-macOS_Apple_Silicon.dmg"
    sha256 "3fd87527ea49b40cd82426870e258db1c61ce8e4622289961502b3a7294fd512"
  end

  name "VLEAPP GUI"
  desc "Digital forensics tool for analyzing vehicle infotainment system artifacts with graphical interface"
  homepage "https://github.com/abrignoni/VLEAPP"

  app "vleappGUI.app"
end
