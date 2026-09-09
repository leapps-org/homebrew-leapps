cask "ileapp-gui" do
  version "v2026.3.3"

  if Hardware::CPU.intel?
    url "https://github.com/abrignoni/iLEAPP/releases/download/v2026.3.3/ileappGUI-v2026.3.3-macOS_Mac_Intel.dmg"
    sha256 "4a680f93c0105141f939d2fada580b419d95eb221d7dc7b599e802c48e787eb8"
  else
    url "https://github.com/abrignoni/iLEAPP/releases/download/v2026.3.3/ileappGUI-v2026.3.3-macOS_Apple_Silicon.dmg"
    sha256 "c713241897d0ce75c03e237e3e26872dab0e32d854647fb5289d6d8e726f8457"
  end

  name "iLEAPP GUI"
  desc "Digital forensics tool for analyzing iOS artifacts with graphical interface"
  homepage "https://github.com/abrignoni/iLEAPP"

  app "ileappGUI.app"
end
