cask "rleapp-gui" do
  version "v2026.4.3"

  if Hardware::CPU.intel?
    url "https://github.com/abrignoni/RLEAPP/releases/download/v2026.4.3/RLEAPP-2026.4.3-macos-x64.dmg"
    sha256 "ffd6a5ca0e700a25839f88ca0f4445d3c92db9c3c6945c51ff4f4d2eb3497442"
  else
    url "https://github.com/abrignoni/RLEAPP/releases/download/v2026.4.3/RLEAPP-2026.4.3-macos-arm64.dmg"
    sha256 "3358dc51466962098dd2cd5620443a4051af8a9eb2f6e9d3ff5cd93df4695050"
  end

  name "RLEAPP"
  desc "Digital forensics tool for parsing service provider warrant or data return files"
  homepage "https://github.com/abrignoni/RLEAPP"

  app "RLEAPP.app"
  binary "#{appdir}/RLEAPP.app/Contents/MacOS/rleapp"
end
