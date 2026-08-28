cask "rleapp-gui" do
  version "v2026.3.1"

  if Hardware::CPU.intel?
    url "https://github.com/abrignoni/RLEAPP/releases/download/v2026.3.1/rleappGUI-v2026.3.1-macOS_Mac_Intel.dmg"
    sha256 "28bfb215cee50474af044365d89ec6e014d7ece969ca532ae7214c768f7bb56d"
  else
    url "https://github.com/abrignoni/RLEAPP/releases/download/v2026.3.1/rleappGUI-v2026.3.1-macOS_Apple_Silicon.dmg"
    sha256 "ef59d29a4d780065ebc884558b42822bcd58b5dcef09c9500591d98eba324c2c"
  end

  name "RLEAPP GUI"
  desc "Digital forensics tool for parsing service provider warrant or data return files with graphical interface"
  homepage "https://github.com/abrignoni/RLEAPP"

  app "rleappGUI.app"
end
