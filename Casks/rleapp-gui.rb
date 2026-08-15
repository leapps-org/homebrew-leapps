cask "rleapp-gui" do
  version "v2026.3.0"

  if Hardware::CPU.intel?
    url "https://github.com/abrignoni/RLEAPP/releases/download/v2026.3.0/rleappGUI-v2026.3.0-macOS_Mac_Intel.dmg"
    sha256 "9e426480238bd1003ddd50581594a1291637270c4a84cefd716325a565aa8a6e"
  else
    url "https://github.com/abrignoni/RLEAPP/releases/download/v2026.3.0/rleappGUI-v2026.3.0-macOS_Apple_Silicon.dmg"
    sha256 "341e3535aee66cb4cbb0973c84a1928a612a76e586cf730d346e84255c7f8bfd"
  end

  name "RLEAPP GUI"
  desc "Digital forensics tool for parsing service provider warrant or data return files with graphical interface"
  homepage "https://github.com/abrignoni/RLEAPP"

  app "rleappGUI.app"
end
