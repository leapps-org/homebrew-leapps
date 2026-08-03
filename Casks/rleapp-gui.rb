cask "rleapp-gui" do
  version "v2026.2.0"

  if Hardware::CPU.intel?
    url "https://github.com/abrignoni/RLEAPP/releases/download/v2026.2.0/rleappGUI-v2026.2.0-macOS_Mac_Intel.dmg"
    sha256 "3012b762910e0880b2fd786219af5eb6e46c65bf8ca7337079fa20903d616462"
  else
    url "https://github.com/abrignoni/RLEAPP/releases/download/v2026.2.0/rleappGUI-v2026.2.0-macOS_Apple_Silicon.dmg"
    sha256 "8757c8b75aca78a7037bb48c94ec3312cd1ddd0846bd973045ce5293d78d9f13"
  end

  name "RLEAPP GUI"
  desc "Digital forensics tool for parsing service provider warrant or data return files with graphical interface"
  homepage "https://github.com/abrignoni/RLEAPP"

  app "rleappGUI.app"
end
