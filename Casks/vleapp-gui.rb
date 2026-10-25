cask "vleapp-gui" do
  version "v2026.4.4"

  if Hardware::CPU.intel?
    url "https://github.com/abrignoni/VLEAPP/releases/download/v2026.4.4/VLEAPP-2026.4.4-macos-x64.dmg"
    sha256 "ac8771cdd5e3e6c9b2512159ef4b83adc73a7244c02e502cc0478572ee5f0d3a"
  else
    url "https://github.com/abrignoni/VLEAPP/releases/download/v2026.4.4/VLEAPP-2026.4.4-macos-arm64.dmg"
    sha256 "88d377ddcba0aa78e212c402d1476d13e6b357688d061852478bebc761819704"
  end

  name "VLEAPP"
  desc "Digital forensics tool for analyzing vehicle infotainment system artifacts"
  homepage "https://github.com/abrignoni/VLEAPP"

  app "VLEAPP.app"
  binary "#{appdir}/VLEAPP.app/Contents/MacOS/vleapp"
end
