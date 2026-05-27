cask "ileapp-gui" do
  version "v2.5.0"

  if Hardware::CPU.intel?
    url "https://github.com/abrignoni/iLEAPP/releases/download/v2.5.0/ileappGUI-v2.5.0-macOS_Mac_Intel.dmg"
    sha256 "a8462b67c2b41ae0639288f665d30fcd7f7dbe7d0f411f177d92b524299bac80"
  else
    url "https://github.com/abrignoni/iLEAPP/releases/download/v2.5.0/ileappGUI-v2.5.0-macOS_Apple_Silicon.dmg"
    sha256 "83f6a09f4417a450510b83353ac2360738ca8d21140d419399f121e373c5c9f0"
  end

  name "iLEAPP GUI"
  desc "Digital forensics tool for analyzing iOS artifacts with graphical interface"
  homepage "https://github.com/abrignoni/iLEAPP"

  app "ileappGUI.app"
end
