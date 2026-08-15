cask "vleapp-gui" do
  version "v2026.3.0"

  if Hardware::CPU.intel?
    url "https://github.com/abrignoni/VLEAPP/releases/download/v2026.3.0/vleappGUI-v2026.3.0-macOS_Mac_Intel.dmg"
    sha256 "1b5d2f09ce4edaaa89214ad6f8202a1bd731ff6d5702a8a602fe8bbddfef06ae"
  else
    url "https://github.com/abrignoni/VLEAPP/releases/download/v2026.3.0/vleappGUI-v2026.3.0-macOS_Apple_Silicon.dmg"
    sha256 "d15a453ddedd83be496d62adeebcf6e7bc19c471011f66f67278720af9fcfd5f"
  end

  name "VLEAPP GUI"
  desc "Digital forensics tool for analyzing vehicle infotainment system artifacts with graphical interface"
  homepage "https://github.com/abrignoni/VLEAPP"

  app "vleappGUI.app"
end
