cask "ileapp-gui" do
  version "v2.1.3"

  if Hardware::CPU.intel?
    url "https://github.com/abrignoni/iLEAPP/releases/download/v2.1.3/ileappGUI-v2.1.3-Mac_Intel.dmg"
    sha256 "e45fd3adf14f588300a034e3ad9a6f1f6715abfa9ea0a859115c679f5c117b8e"
  else
    url "https://github.com/abrignoni/iLEAPP/releases/download/v2.1.3/ileappGUI-v2.1.3-Apple_Silicon.dmg"
    sha256 "e5dcd5c5e9982561abf9655973607fd778233e70aeb788e9831fb7d7c6e64036"
  end

  name "iLEAPP GUI"
  desc "Digital forensics tool for analyzing iOS artifacts with graphical interface"
  homepage "https://github.com/abrignoni/iLEAPP"

  app "ileappGUI.app"
end
