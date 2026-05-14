cask "aleapp-gui" do
  version "v3.4.1"

  if Hardware::CPU.intel?
    url "https://github.com/abrignoni/aLEAPP/releases/download/v3.4.1/aleappGUI-v3.4.1-Mac_Intel.dmg"
    sha256 "b568d2d9e86dbf189b5023e180849192fab7e333d043ede94a7aeec55f9ef8d9"
  else
    url "https://github.com/abrignoni/aLEAPP/releases/download/v3.4.1/aleappGUI-v3.4.1-Apple_Silicon.dmg"
    sha256 "4ae1fef0425f0de790b82ad3ef2808b3f1d02cbbe1a25f842aa78fcde0278208"
  end

  name "aLEAPP GUI"
  desc "Digital forensics tool for analyzing Android artifacts with graphical interface"
  homepage "https://github.com/abrignoni/aLEAPP"

  app "aleappGUI.app"
end
