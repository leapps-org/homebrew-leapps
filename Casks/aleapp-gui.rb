cask "aleapp-gui" do
  version "v2026.3.1"

  if Hardware::CPU.intel?
    url "https://github.com/abrignoni/ALEAPP/releases/download/v2026.3.1/aleappGUI-v2026.3.1-macOS_Mac_Intel.dmg"
    sha256 "deb0f1667db71a31fb0ed992b0a27f19ec0e6d9f503a732df611eb6fdc6e47ea"
  else
    url "https://github.com/abrignoni/ALEAPP/releases/download/v2026.3.1/aleappGUI-v2026.3.1-macOS_Apple_Silicon.dmg"
    sha256 "2a6a976c31aa4ee741765c72c1088b4bc33c5f33b38e314246ba8af304cf6a7b"
  end

  name "aLEAPP GUI"
  desc "Digital forensics tool for analyzing Android artifacts with graphical interface"
  homepage "https://github.com/abrignoni/aLEAPP"

  app "aleappGUI.app"
end
