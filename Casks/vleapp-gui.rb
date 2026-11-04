cask "vleapp-gui" do
  version "v2026.4.5"

  if Hardware::CPU.intel?
    url "https://github.com/abrignoni/VLEAPP/releases/download/v2026.4.5/VLEAPP-2026.4.5-macos-x64.dmg"
    sha256 "49477abe7b8d24249fcacd79178fe5341f940da7829d51a2fdc1a3ec67090617"
  else
    url "https://github.com/abrignoni/VLEAPP/releases/download/v2026.4.5/VLEAPP-2026.4.5-macos-arm64.dmg"
    sha256 "d616ff8c8d89a15022cffb09e823af6f06eeb71822a40a72a9f31b727b6c8860"
  end

  name "VLEAPP"
  desc "Digital forensics tool for analyzing vehicle infotainment system artifacts"
  homepage "https://github.com/abrignoni/VLEAPP"

  app "VLEAPP.app"
  binary "#{appdir}/VLEAPP.app/Contents/MacOS/vleapp"
end
