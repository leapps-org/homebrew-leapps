cask "rleapp-gui" do
  version "v2.2.0"

  if Hardware::CPU.intel?
    url "https://github.com/abrignoni/RLEAPP/releases/download/v2.2.0/rleappGUI-v2.2.0-macOS_Mac_Intel.dmg"
    sha256 "702b0b9c8afdebf984c82ddd06094f2bb0681fc4b9ad4250902f86cfcdcb1bc6"
  else
    url "https://github.com/abrignoni/RLEAPP/releases/download/v2.2.0/rleappGUI-v2.2.0-macOS_Apple_Silicon.dmg"
    sha256 "9ecb2dabc9bbbf4213f7e36425be7d712b77b8cae9f7ef56b6ebf43960782260"
  end

  name "RLEAPP GUI"
  desc "Digital forensics tool for parsing service provider warrant or data return files with graphical interface"
  homepage "https://github.com/abrignoni/RLEAPP"

  app "rleappGUI.app"
end
