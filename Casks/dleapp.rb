cask "dleapp" do
  version "v2026.4.5"

  if Hardware::CPU.intel?
    url "https://github.com/abrignoni/DLEAPP/releases/download/v2026.4.5/DLEAPP-2026.4.5-macos-x64.dmg"
    sha256 "1701d15a76f982717611b77a31470022e99f1104bf31bf7b10eaa64281a94210"
  else
    url "https://github.com/abrignoni/DLEAPP/releases/download/v2026.4.5/DLEAPP-2026.4.5-macos-arm64.dmg"
    sha256 "e1f2ccbb09f4c555e10ad05b44152046693266347ee7c8021d0cc1f6bb7a0571"
  end

  name "DLEAPP"
  desc "Digital forensics tool for parsing desktop operating system artifacts"
  homepage "https://github.com/abrignoni/DLEAPP"

  app "DLEAPP.app"
  binary "#{appdir}/DLEAPP.app/Contents/MacOS/dleapp"
end
