cask "rleapp" do
  version "v2026.4.6"

  if Hardware::CPU.intel?
    url "https://github.com/abrignoni/RLEAPP/releases/download/v2026.4.6/RLEAPP-2026.4.6-macos-x64.dmg"
    sha256 "d95e5cb765c941195c86492a9ab7115f9931c2bd33824de8efd33b9b8cea290b"
  else
    url "https://github.com/abrignoni/RLEAPP/releases/download/v2026.4.6/RLEAPP-2026.4.6-macos-arm64.dmg"
    sha256 "6944fc2d584efded0ef2da7c9735d175dfbbf3c641e8825f75b55761211be7c5"
  end

  name "RLEAPP"
  desc "Digital forensics tool for parsing service provider warrant or data return files"
  homepage "https://github.com/abrignoni/RLEAPP"

  app "RLEAPP.app"
  binary "#{appdir}/RLEAPP.app/Contents/MacOS/rleapp"
end
