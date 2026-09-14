cask "aleapp-gui" do
  version "v2026.4.0"

  if Hardware::CPU.intel?
    url "https://github.com/abrignoni/ALEAPP/releases/download/v2026.4.0/aleappGUI-v2026.4.0-macOS_Mac_Intel.dmg"
    sha256 "2001957697b2ccffeda341ef0aa05590c50edb9662dd7a78c30dffc0e956b5ac"
  else
    url "https://github.com/abrignoni/ALEAPP/releases/download/v2026.4.0/aleappGUI-v2026.4.0-macOS_Apple_Silicon.dmg"
    sha256 "a3791120ff3f6e582b1a9e9f5710621e81bb31d6f8951110a5e6b0ea76eb3818"
  end

  name "aLEAPP GUI"
  desc "Digital forensics tool for analyzing Android artifacts with graphical interface"
  homepage "https://github.com/abrignoni/aLEAPP"

  app "aleappGUI.app"
end
