cask "aleapp-gui" do
  version "v2026.4.5"

  if Hardware::CPU.intel?
    url "https://github.com/abrignoni/ALEAPP/releases/download/v2026.4.5/ALEAPP-2026.4.5-macos-x64.dmg"
    sha256 "508a478e67b759ff5b37790d80a0bc236f0487509c8fcf33d80dd554adb2733e"
  else
    url "https://github.com/abrignoni/ALEAPP/releases/download/v2026.4.5/ALEAPP-2026.4.5-macos-arm64.dmg"
    sha256 "373709973c6cfe07ee8a9281dff6b82b7f157bbda0c6fa8b1cce99670f776369"
  end

  name "ALEAPP"
  desc "Digital forensics tool for analyzing Android artifacts"
  homepage "https://github.com/abrignoni/ALEAPP"

  app "ALEAPP.app"
  binary "#{appdir}/ALEAPP.app/Contents/MacOS/aleapp"
end
