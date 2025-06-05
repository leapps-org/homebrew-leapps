cask "rleapp-gui" do
  version "v1.1.2"

  if Hardware::CPU.intel?
    url "https://github.com/abrignoni/RLEAPP/releases/download/v1.1.2/rleappGUI-1.1.2-Mac_Intel.dmg"
    sha256 "daec03ddff815b7174cf8281f64513f5290e53fec87d0095e57e9a0acf5185c8"
  else
    url "https://github.com/abrignoni/RLEAPP/releases/download/v1.1.2/rleappGUI-1.1.2-Apple_Silicon.dmg"
    sha256 "71e12e711b7c4977ffac998d8e6c668220fcd31239645a0d73f84cc99e966386"
  end

  name "RLEAPP GUI"
  desc "Digital forensics tool for parsing service provider warrant or data return files with graphical interface"
  homepage "https://github.com/abrignoni/RLEAPP"

  app "rleappGUI.app"
end
