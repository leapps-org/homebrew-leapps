cask "ileapp-gui" do
  version "v2026.4.2"

  if Hardware::CPU.intel?
    url "https://github.com/abrignoni/iLEAPP/releases/download/v2026.4.2/ileappGUI-v2026.4.2-macOS_Mac_Intel.dmg"
    sha256 "1e04f068cbe2f9412292a53fecd0b0ec4a6e8bb3591632ed3aa069c47d8e86d8"
  else
    url "https://github.com/abrignoni/iLEAPP/releases/download/v2026.4.2/ileappGUI-v2026.4.2-macOS_Apple_Silicon.dmg"
    sha256 "9469900720ce6b0beb9f9487a3f7230af2e0155b7e986011d456140828b8bfc6"
  end

  name "iLEAPP GUI"
  desc "Digital forensics tool for analyzing iOS artifacts with graphical interface"
  homepage "https://github.com/abrignoni/iLEAPP"

  app "ileappGUI.app"
end
