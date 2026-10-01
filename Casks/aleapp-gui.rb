cask "aleapp-gui" do
  version "v2026.4.2"

  if Hardware::CPU.intel?
    url "https://github.com/abrignoni/ALEAPP/releases/download/v2026.4.2/ALEAPP-2026.4.2-macos-x64.dmg"
    sha256 "c4563c2fb57bcf3de666818fbd85c839c3f248921991af88f1288674495dcee2"
  else
    url "https://github.com/abrignoni/ALEAPP/releases/download/v2026.4.2/ALEAPP-2026.4.2-macos-arm64.dmg"
    sha256 "f68752dc05bcf2045646e1353990bdd9b6cd0b4ba48ae4eafd12cbc9bf06f1fb"
  end

  name "ALEAPP"
  desc "Digital forensics tool for analyzing Android artifacts"
  homepage "https://github.com/abrignoni/ALEAPP"

  app "ALEAPP.app"
  binary "#{appdir}/ALEAPP.app/Contents/MacOS/aleapp"
end
