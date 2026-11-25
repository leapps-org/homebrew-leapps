cask "vleapp" do
  version "v2026.4.6"

  if Hardware::CPU.intel?
    url "https://github.com/abrignoni/VLEAPP/releases/download/v2026.4.6/VLEAPP-2026.4.6-macos-x64.dmg"
    sha256 "4ef635885c72c9b9c41a94b0ccc0891d0c8a11ccb177075ebd2e1017786f06b9"
  else
    url "https://github.com/abrignoni/VLEAPP/releases/download/v2026.4.6/VLEAPP-2026.4.6-macos-arm64.dmg"
    sha256 "b484791dc56b6eb70d6b4cf259728000d1d7556dcdf45bd4c1c231d939582001"
  end

  name "VLEAPP"
  desc "Digital forensics tool for parsing vehicle infotainment system backup files, images, and artifacts"
  homepage "https://github.com/abrignoni/VLEAPP"

  app "VLEAPP.app"
  binary "#{appdir}/VLEAPP.app/Contents/MacOS/vleapp"
end
