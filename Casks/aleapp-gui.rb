cask "aleapp-gui" do
  version "v3.5.0"

  if Hardware::CPU.intel?
    url "https://github.com/abrignoni/aLEAPP/releases/download/v3.5.0/aleappGUI-v3.5.0-macOS_Mac_Intel.dmg"
    sha256 "2e60e2b993e6121e8a6fe22176e9bb05ead9288b25fe99e998332aece7cf82f5"
  else
    url "https://github.com/abrignoni/aLEAPP/releases/download/v3.5.0/aleappGUI-v3.5.0-macOS_Apple_Silicon.dmg"
    sha256 "e54a0949c19c3347ad62c04b1df8dea459bf93086dcf26be989f6978a812d743"
  end

  name "aLEAPP GUI"
  desc "Digital forensics tool for analyzing Android artifacts with graphical interface"
  homepage "https://github.com/abrignoni/aLEAPP"

  app "aleappGUI.app"
end
