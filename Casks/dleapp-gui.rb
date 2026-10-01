cask "dleapp-gui" do
  version "v2026.4.2"

  if Hardware::CPU.intel?
    url "https://github.com/abrignoni/DLEAPP/releases/download/v2026.4.2/DLEAPP-2026.4.2-macos-x64.dmg"
    sha256 "7aaed4280397b2b545930cecbd31e6e78c96e2970f838f78922c972daca6345c"
  else
    url "https://github.com/abrignoni/DLEAPP/releases/download/v2026.4.2/DLEAPP-2026.4.2-macos-arm64.dmg"
    sha256 "42ee0b04c35078c4e1907c02ea5babdc0fbdfca83e17e7e4d529ab97e814c98e"
  end

  name "DLEAPP"
  desc "Digital forensics tool for analyzing desktop computer artifacts"
  homepage "https://github.com/abrignoni/DLEAPP"

  app "DLEAPP.app"
  binary "#{appdir}/DLEAPP.app/Contents/MacOS/dleapp"
end
