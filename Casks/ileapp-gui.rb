cask "ileapp-gui" do
  version "v2026.3.1"

  if Hardware::CPU.intel?
    url "https://github.com/abrignoni/iLEAPP/releases/download/v2026.3.1/ileappGUI-v2026.3.1-macOS_Mac_Intel.dmg"
    sha256 "419405e2b081de29248954b7a49b311c0b04e54ae8e7fe16c4b756fbfe2ffc95"
  else
    url "https://github.com/abrignoni/iLEAPP/releases/download/v2026.3.1/ileappGUI-v2026.3.1-macOS_Apple_Silicon.dmg"
    sha256 "0784056f1e45a4580cddb1cc3564d8fab37930bccbe82e484759afb876a19377"
  end

  name "iLEAPP GUI"
  desc "Digital forensics tool for analyzing iOS artifacts with graphical interface"
  homepage "https://github.com/abrignoni/iLEAPP"

  app "ileappGUI.app"
end
