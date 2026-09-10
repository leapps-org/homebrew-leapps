cask "aleapp-gui" do
  version "v2026.3.3"

  if Hardware::CPU.intel?
    url "https://github.com/abrignoni/ALEAPP/releases/download/v2026.3.3/aleappGUI-v2026.3.3-macOS_Mac_Intel.dmg"
    sha256 "846bca82932a8dc4c8b4cfff5dba6d2023204e517a961f3586795faf5ad15e01"
  else
    url "https://github.com/abrignoni/ALEAPP/releases/download/v2026.3.3/aleappGUI-v2026.3.3-macOS_Apple_Silicon.dmg"
    sha256 "2d761cfab71cec3ab71908401d9a02e08b7dfb82693f2525da966ccf986e8124"
  end

  name "aLEAPP GUI"
  desc "Digital forensics tool for analyzing Android artifacts with graphical interface"
  homepage "https://github.com/abrignoni/aLEAPP"

  app "aleappGUI.app"
end
