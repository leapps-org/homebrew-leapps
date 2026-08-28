cask "ileapp-gui" do
  version "v2026.3.2"

  if Hardware::CPU.intel?
    url "https://github.com/abrignoni/iLEAPP/releases/download/v2026.3.2/ileappGUI-v2026.3.2-macOS_Mac_Intel.dmg"
    sha256 "b41841adabf370acf389ca904800e8280575fafa90f99daf30f5558fa61989f7"
  else
    url "https://github.com/abrignoni/iLEAPP/releases/download/v2026.3.2/ileappGUI-v2026.3.2-macOS_Apple_Silicon.dmg"
    sha256 "694cbda7a925e941667b6395d64357a5d51640f9ffb7a4bb0371e79b27d99a95"
  end

  name "iLEAPP GUI"
  desc "Digital forensics tool for analyzing iOS artifacts with graphical interface"
  homepage "https://github.com/abrignoni/iLEAPP"

  app "ileappGUI.app"
end
