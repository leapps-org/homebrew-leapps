cask "ileapp-gui" do
  version "v2026.1.0"

  if Hardware::CPU.intel?
    url "https://github.com/abrignoni/iLEAPP/releases/download/v2026.1.0/ileappGUI-v2026.1.0-macOS_Mac_Intel.dmg"
    sha256 "f8795aa058dec8aeb881f32b7556455f6ea86d0fe4b8ddd54518a0ec2ddd6c92"
  else
    url "https://github.com/abrignoni/iLEAPP/releases/download/v2026.1.0/ileappGUI-v2026.1.0-macOS_Apple_Silicon.dmg"
    sha256 "359076d1f77fc9e5057b67fb195187b951185008567d1e4bf3dce8876c247197"
  end

  name "iLEAPP GUI"
  desc "Digital forensics tool for analyzing iOS artifacts with graphical interface"
  homepage "https://github.com/abrignoni/iLEAPP"

  app "ileappGUI.app"
end
