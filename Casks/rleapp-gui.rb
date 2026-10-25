cask "rleapp-gui" do
  version "v2026.4.4"

  if Hardware::CPU.intel?
    url "https://github.com/abrignoni/RLEAPP/releases/download/v2026.4.4/RLEAPP-2026.4.4-macos-x64.dmg"
    sha256 "e68eaa1b492e884ae56e9e1105c6ed9c3b15322dc4b2b97b4860f9f375d82977"
  else
    url "https://github.com/abrignoni/RLEAPP/releases/download/v2026.4.4/RLEAPP-2026.4.4-macos-arm64.dmg"
    sha256 "c490d839732c2f91bb7a70c3948819e82bb5921e104d4fe3fd772f1bca667838"
  end

  name "RLEAPP"
  desc "Digital forensics tool for parsing service provider warrant or data return files"
  homepage "https://github.com/abrignoni/RLEAPP"

  app "RLEAPP.app"
  binary "#{appdir}/RLEAPP.app/Contents/MacOS/rleapp"
end
