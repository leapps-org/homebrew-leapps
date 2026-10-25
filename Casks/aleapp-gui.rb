cask "aleapp-gui" do
  version "v2026.4.4"

  if Hardware::CPU.intel?
    url "https://github.com/abrignoni/ALEAPP/releases/download/v2026.4.4/ALEAPP-2026.4.4-macos-x64.dmg"
    sha256 "461c63eb45345b5d4aee932e0bcf101fa257fab07aa0aad5cb61c65f15958a0b"
  else
    url "https://github.com/abrignoni/ALEAPP/releases/download/v2026.4.4/ALEAPP-2026.4.4-macos-arm64.dmg"
    sha256 "d05e50cf28926da999ee4f906000e083bd7a52e3c86013cc5c5927b17a752169"
  end

  name "ALEAPP"
  desc "Digital forensics tool for analyzing Android artifacts"
  homepage "https://github.com/abrignoni/ALEAPP"

  app "ALEAPP.app"
  binary "#{appdir}/ALEAPP.app/Contents/MacOS/aleapp"
end
