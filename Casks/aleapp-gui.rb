cask "aleapp-gui" do
  version "v2026.3.2"

  if Hardware::CPU.intel?
    url "https://github.com/abrignoni/ALEAPP/releases/download/v2026.3.2/aleappGUI-v2026.3.2-macOS_Mac_Intel.dmg"
    sha256 "d61a91d7adce86c71b771dcf67ad70e4b79701b6b2479e0d14e6b882e58049d4"
  else
    url "https://github.com/abrignoni/ALEAPP/releases/download/v2026.3.2/aleappGUI-v2026.3.2-macOS_Apple_Silicon.dmg"
    sha256 "ed086650e7c8cde70ad02587d92cc36b4e5e83cc2465ba656a697209f4b95fc1"
  end

  name "aLEAPP GUI"
  desc "Digital forensics tool for analyzing Android artifacts with graphical interface"
  homepage "https://github.com/abrignoni/aLEAPP"

  app "aleappGUI.app"
end
