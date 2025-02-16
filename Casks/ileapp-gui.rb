cask "ileapp-gui" do
  version "v2.1.0"

  if Hardware::CPU.intel?
    url "https://github.com/abrignoni/iLEAPP/releases/download/v2.1.0/ileappGUI-v2.1.0-Mac_Intel.dmg"
    sha256 "6f43d49873b47e313ae1016d401c6e4362f2235826c06c865cabf150e0dbb4c5"
  else
    url "https://github.com/abrignoni/iLEAPP/releases/download/v2.1.0/ileappGUI-v2.1.0-Apple_Silicon.dmg"
    sha256 "444ddf10ad5be23b760137dd3672696a69a1d5de8c511547bc377fbccf756093"
  end

  name "iLEAPP GUI"
  desc "Digital forensics tool for analyzing iOS artifacts with graphical interface"
  homepage "https://github.com/abrignoni/iLEAPP"

  app "ileappGUI.app"
end
