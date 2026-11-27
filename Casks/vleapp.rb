cask "vleapp" do
  version "v2026.5.0"

  if Hardware::CPU.intel?
    url "https://github.com/abrignoni/VLEAPP/releases/download/v2026.5.0/VLEAPP-2026.5.0-macos-x64.dmg"
    sha256 "36eed3d22096e2ac85cbb1ea5ac7df0d5264d50653b3dc021f25e01cb2ef85c8"
  else
    url "https://github.com/abrignoni/VLEAPP/releases/download/v2026.5.0/VLEAPP-2026.5.0-macos-arm64.dmg"
    sha256 "0eb01620e212a9b93ea357295d3de4c69b3c6f63688f9cc38358efaaf1115b26"
  end

  name "VLEAPP"
  desc "Digital forensics tool for parsing vehicle infotainment system backup files, images, and artifacts"
  homepage "https://github.com/abrignoni/VLEAPP"

  app "VLEAPP.app"
  binary "#{appdir}/VLEAPP.app/Contents/MacOS/vleapp"
end
