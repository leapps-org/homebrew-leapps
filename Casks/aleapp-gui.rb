cask "aleapp-gui" do
  version "v2026.1.0"

  if Hardware::CPU.intel?
    url "https://github.com/abrignoni/ALEAPP/releases/download/v2026.1.0/aleappGUI-v2026.1.0-macOS_Mac_Intel.dmg"
    sha256 "c2fe6aeab6585887bfc8b5af1b4e804acee22d02ecff2f10bf7899a625024896"
  else
    url "https://github.com/abrignoni/ALEAPP/releases/download/v2026.1.0/aleappGUI-v2026.1.0-macOS_Apple_Silicon.dmg"
    sha256 "44ea38979f3a3c4afc02086ad3dae41ba3f2f7ae1ccd10a4eb939e22b81dd795"
  end

  name "aLEAPP GUI"
  desc "Digital forensics tool for analyzing Android artifacts with graphical interface"
  homepage "https://github.com/abrignoni/aLEAPP"

  app "aleappGUI.app"
end
