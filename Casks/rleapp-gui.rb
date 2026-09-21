cask "rleapp-gui" do
  version "v2026.4.1"

  if Hardware::CPU.intel?
    url "https://github.com/abrignoni/RLEAPP/releases/download/v2026.4.1/rleappGUI-v2026.4.1-macOS_Mac_Intel.dmg"
    sha256 "95a177874da9e51acfb1b4b4cab1dce3bdbf77b3f6f7c5408955788fa23b5eb6"
  else
    url "https://github.com/abrignoni/RLEAPP/releases/download/v2026.4.1/rleappGUI-v2026.4.1-macOS_Apple_Silicon.dmg"
    sha256 "d0ab5c884516c61dc73762f9b08d402ce7c86d8e7d92153701e82eaf5d2d769b"
  end

  name "RLEAPP GUI"
  desc "Digital forensics tool for parsing service provider warrant or data return files with graphical interface"
  homepage "https://github.com/abrignoni/RLEAPP"

  app "rleappGUI.app"
end
