cask "aleapp-gui" do
  version "v3.6.0"

  if Hardware::CPU.intel?
    url "https://github.com/abrignoni/ALEAPP/releases/download/v3.6.0/aleappGUI-v3.6.0-macOS_Mac_Intel.dmg"
    sha256 "1528192bc7cde0808347e104dd79a2fec680a2ce33032425c5b6558662c21c43"
  else
    url "https://github.com/abrignoni/ALEAPP/releases/download/v3.6.0/aleappGUI-v3.6.0-macOS_Apple_Silicon.dmg"
    sha256 "a77a54759ca56544129a36c6e1bafaa5dd8b63046257c3a8dd3f62850899df4f"
  end

  name "aLEAPP GUI"
  desc "Digital forensics tool for analyzing Android artifacts with graphical interface"
  homepage "https://github.com/abrignoni/aLEAPP"

  app "aleappGUI.app"
end
