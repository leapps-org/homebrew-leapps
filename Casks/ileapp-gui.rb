cask "ileapp-gui" do
  version "v2026.3.0"

  if Hardware::CPU.intel?
    url "https://github.com/abrignoni/iLEAPP/releases/download/v2026.3.0/ileappGUI-v2026.3.0-macOS_Mac_Intel.dmg"
    sha256 "4399a4eb02793817462a40a92fda83ba01b890e7eb45bcb9e0d032fb4f2eaa64"
  else
    url "https://github.com/abrignoni/iLEAPP/releases/download/v2026.3.0/ileappGUI-v2026.3.0-macOS_Apple_Silicon.dmg"
    sha256 "1c374b4db8153433a069920739eab99a4e56b2f6634a3b08ad94ddf6189c6a42"
  end

  name "iLEAPP GUI"
  desc "Digital forensics tool for analyzing iOS artifacts with graphical interface"
  homepage "https://github.com/abrignoni/iLEAPP"

  app "ileappGUI.app"
end
