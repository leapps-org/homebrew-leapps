cask "aleapp-gui" do
  version "v2026.4.1"

  if Hardware::CPU.intel?
    url "https://github.com/abrignoni/ALEAPP/releases/download/v2026.4.1/aleappGUI-v2026.4.1-macOS_Mac_Intel.dmg"
    sha256 "6ebc4d76ad102a56a58292a9dde5045629daf5ff76ddab1fa5e0049476396e4a"
  else
    url "https://github.com/abrignoni/ALEAPP/releases/download/v2026.4.1/aleappGUI-v2026.4.1-macOS_Apple_Silicon.dmg"
    sha256 "45883e30f35ba70206cc1f06916b03a26e39c1b4e235e698e190cc5bd4a38ef3"
  end

  name "aLEAPP GUI"
  desc "Digital forensics tool for analyzing Android artifacts with graphical interface"
  homepage "https://github.com/abrignoni/aLEAPP"

  app "aleappGUI.app"
end
