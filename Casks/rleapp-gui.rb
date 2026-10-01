cask "rleapp-gui" do
  version "v2026.4.2"

  if Hardware::CPU.intel?
    url "https://github.com/abrignoni/RLEAPP/releases/download/v2026.4.2/RLEAPP-2026.4.2-macos-x64.dmg"
    sha256 "0aedb8af4fd6f1bfd597ac9b5a7dfb6551e0054197baae2453867df16e51d3c9"
  else
    url "https://github.com/abrignoni/RLEAPP/releases/download/v2026.4.2/RLEAPP-2026.4.2-macos-arm64.dmg"
    sha256 "e0b688e9107ca23e724f494ae6d29c6a58cbd59d341743c99f74ccf24e6e5f8e"
  end

  name "RLEAPP"
  desc "Digital forensics tool for parsing service provider warrant or data return files"
  homepage "https://github.com/abrignoni/RLEAPP"

  app "RLEAPP.app"
  binary "#{appdir}/RLEAPP.app/Contents/MacOS/rleapp"
end
