cask "ileapp-gui" do
  version "v2.2.0"

  if Hardware::CPU.intel?
    url "https://github.com/abrignoni/iLEAPP/releases/download/v2.2.0/ileappGUI-v2.2.0-Mac_Intel.dmg"
    sha256 "350dc943f26da65c0e27f43362c28208a48259093618ed2475ea518c74911b9d"
  else
    url "https://github.com/abrignoni/iLEAPP/releases/download/v2.2.0/ileappGUI-v2.2.0-Apple_Silicon.dmg"
    sha256 "7aa83bea9a5c37691509a1ff8021a6b64fb8c89766e9ce19df1ab26a09f729d8"
  end

  name "iLEAPP GUI"
  desc "Digital forensics tool for analyzing iOS artifacts with graphical interface"
  homepage "https://github.com/abrignoni/iLEAPP"

  app "ileappGUI.app"
end
