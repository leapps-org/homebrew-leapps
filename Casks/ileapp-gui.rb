cask "ileapp-gui" do
  version "v2026.2.0"

  if Hardware::CPU.intel?
    url "https://github.com/abrignoni/iLEAPP/releases/download/v2026.2.0/ileappGUI-v2026.2.0-macOS_Mac_Intel.dmg"
    sha256 "879fa4084a0ca6f8706199a651ace1750baab5b6bdd08a4dbe8fbc7a0b001c72"
  else
    url "https://github.com/abrignoni/iLEAPP/releases/download/v2026.2.0/ileappGUI-v2026.2.0-macOS_Apple_Silicon.dmg"
    sha256 "98952c06a491559b90121fa7b9c66db6ca0172cfe46961a23ee7cd2f2cb68d8e"
  end

  name "iLEAPP GUI"
  desc "Digital forensics tool for analyzing iOS artifacts with graphical interface"
  homepage "https://github.com/abrignoni/iLEAPP"

  app "ileappGUI.app"
end
