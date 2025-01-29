cask "ileapp-gui" do
  version "v2.0.4"

  if Hardware::CPU.intel?
    url "https://github.com/abrignoni/iLEAPP/releases/download/v2.0.4/ileappGUI-v2.0.4-Mac_Intel.dmg"
    sha256 "d0d8cf50e8fc74e7eb16e433109df41561429491586994b8edb68c82b7bab21f"
  else
    url "https://github.com/abrignoni/iLEAPP/releases/download/v2.0.4/ileappGUI-v2.0.4-Apple_Silicon.dmg"
    sha256 "5a57582aef240a44c394daf2edaa0ceb209823de45ad928c73f9465dbf7d778b"
  end

  name "iLEAPP GUI"
  desc "Digital forensics tool for analyzing iOS artifacts with graphical interface"
  homepage "https://github.com/abrignoni/iLEAPP"

  app "ileappGUI.app"
end
