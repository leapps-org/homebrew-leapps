cask "ileapp-gui" do
  version "v2.3.1"

  if Hardware::CPU.intel?
    url "https://github.com/abrignoni/iLEAPP/releases/download/v2.3.1/ileappGUI-v2.3.1-Mac_Intel.dmg"
    sha256 "b9e929bdc26267839d74e15a7c68f2de0c66eb63c47ec488a7611b7573e811cb"
  else
    url "https://github.com/abrignoni/iLEAPP/releases/download/v2.3.1/ileappGUI-v2.3.1-Apple_Silicon.dmg"
    sha256 "d9a5a2019c69e38167a0568acd12c9c4e98a2e4f5a600f0306af6c772d6ae745"
  end

  name "iLEAPP GUI"
  desc "Digital forensics tool for analyzing iOS artifacts with graphical interface"
  homepage "https://github.com/abrignoni/iLEAPP"

  app "ileappGUI.app"
end
