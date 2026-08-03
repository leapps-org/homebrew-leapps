cask "aleapp-gui" do
  version "v2026.2.0"

  if Hardware::CPU.intel?
    url "https://github.com/abrignoni/ALEAPP/releases/download/v2026.2.0/aleappGUI-v2026.2.0-macOS_Mac_Intel.dmg"
    sha256 "86f798123544a82ad35ce4883c1bdbc521b82696e867d817f9456ac8da277509"
  else
    url "https://github.com/abrignoni/ALEAPP/releases/download/v2026.2.0/aleappGUI-v2026.2.0-macOS_Apple_Silicon.dmg"
    sha256 "709e8ba42abc9590635a08fe3f121891895c9d494fedcc398b5b7840b859a3e3"
  end

  name "aLEAPP GUI"
  desc "Digital forensics tool for analyzing Android artifacts with graphical interface"
  homepage "https://github.com/abrignoni/aLEAPP"

  app "aleappGUI.app"
end
