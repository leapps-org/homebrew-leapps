cask "dleapp-gui" do
  version "v2026.4.3"

  if Hardware::CPU.intel?
    url "https://github.com/abrignoni/DLEAPP/releases/download/v2026.4.3/DLEAPP-2026.4.3-macos-x64.dmg"
    sha256 "840656dc32d566adf914a6034993fd40b8aa32066e4b60d9317955cb109db78c"
  else
    url "https://github.com/abrignoni/DLEAPP/releases/download/v2026.4.3/DLEAPP-2026.4.3-macos-arm64.dmg"
    sha256 "b3b63adbab63a9667e49a230ff0bb72d1526bb42e4f16934f2fecd64215bdae0"
  end

  name "DLEAPP"
  desc "Digital forensics tool for analyzing desktop computer artifacts"
  homepage "https://github.com/abrignoni/DLEAPP"

  app "DLEAPP.app"
  binary "#{appdir}/DLEAPP.app/Contents/MacOS/dleapp"
end
