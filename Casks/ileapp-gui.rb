cask "ileapp-gui" do
  version "v2026.4.1"

  if Hardware::CPU.intel?
    url "https://github.com/abrignoni/iLEAPP/releases/download/v2026.4.1/ileappGUI-v2026.4.1-macOS_Mac_Intel.dmg"
    sha256 "8f9118b4b3a10fd89e5dc5b52c4bab2c88527c0906871899e91a17848fae71cb"
  else
    url "https://github.com/abrignoni/iLEAPP/releases/download/v2026.4.1/ileappGUI-v2026.4.1-macOS_Apple_Silicon.dmg"
    sha256 "891766e87763230ce112a6fc00d7e3948ed440a58132a3d55e199e4ddd205db8"
  end

  name "iLEAPP GUI"
  desc "Digital forensics tool for analyzing iOS artifacts with graphical interface"
  homepage "https://github.com/abrignoni/iLEAPP"

  app "ileappGUI.app"
end
