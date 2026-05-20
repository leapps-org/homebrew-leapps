cask "ileapp-gui" do
  version "v2.4.0"

  if Hardware::CPU.intel?
    url "https://github.com/abrignoni/iLEAPP/releases/download/v2.4.0/ileappGUI-v2.4.0-macOS_Mac_Intel.dmg"
    sha256 "a49dbcb6569bb2b142d528631cdb70436b324d1f998b4053e8e406d9fc5adc77"
  else
    url "https://github.com/abrignoni/iLEAPP/releases/download/v2.4.0/ileappGUI-v2.4.0-macOS_Apple_Silicon.dmg"
    sha256 "cd608af04a2aff79541fe18e8bcaed8aa4d66781f7d8d85883b7be68a8af4c42"
  end

  name "iLEAPP GUI"
  desc "Digital forensics tool for analyzing iOS artifacts with graphical interface"
  homepage "https://github.com/abrignoni/iLEAPP"

  app "ileappGUI.app"
end
