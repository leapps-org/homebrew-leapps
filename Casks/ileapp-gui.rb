cask "ileapp-gui" do
  version "v2026.4.0"

  if Hardware::CPU.intel?
    url "https://github.com/abrignoni/iLEAPP/releases/download/v2026.4.0/ileappGUI-v2026.4.0-macOS_Mac_Intel.dmg"
    sha256 "640bc2d70cd5b298825b0dfb64174e1bc9db3bc01b4ee6dc4327fcb9990d6449"
  else
    url "https://github.com/abrignoni/iLEAPP/releases/download/v2026.4.0/ileappGUI-v2026.4.0-macOS_Apple_Silicon.dmg"
    sha256 "d555d5edb54d81e4ede50f7717f58c86497fea1ecf12d975e475b8c602562f6d"
  end

  name "iLEAPP GUI"
  desc "Digital forensics tool for analyzing iOS artifacts with graphical interface"
  homepage "https://github.com/abrignoni/iLEAPP"

  app "ileappGUI.app"
end
