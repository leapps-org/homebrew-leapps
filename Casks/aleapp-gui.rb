cask "aleapp-gui" do
  version "v2026.3.0"

  if Hardware::CPU.intel?
    url "https://github.com/abrignoni/ALEAPP/releases/download/v2026.3.0/aleappGUI-v2026.3.0-macOS_Mac_Intel.dmg"
    sha256 "2e663006f841262a078589343fc4486f183f6181d476926b702f222acd512d44"
  else
    url "https://github.com/abrignoni/ALEAPP/releases/download/v2026.3.0/aleappGUI-v2026.3.0-macOS_Apple_Silicon.dmg"
    sha256 "aacad0eb28ee6a7a7bce0decddeaf9c48c15ba0859dfc5cdb6253068f8fd9e8c"
  end

  name "aLEAPP GUI"
  desc "Digital forensics tool for analyzing Android artifacts with graphical interface"
  homepage "https://github.com/abrignoni/aLEAPP"

  app "aleappGUI.app"
end
