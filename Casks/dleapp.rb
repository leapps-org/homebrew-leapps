cask "dleapp" do
  version "v2026.5.0"

  if Hardware::CPU.intel?
    url "https://github.com/abrignoni/DLEAPP/releases/download/v2026.5.0/DLEAPP-2026.5.0-macos-x64.dmg"
    sha256 "1cf0dbaf4623d0a03b0053e1a49d057e94f4e4083a6d4595f56c523300b0dbd1"
  else
    url "https://github.com/abrignoni/DLEAPP/releases/download/v2026.5.0/DLEAPP-2026.5.0-macos-arm64.dmg"
    sha256 "777e59c080762a4c25784a791ac886b1150116e7859dea89da4687c52edbb965"
  end

  name "DLEAPP"
  desc "Digital forensics tool for parsing desktop operating system artifacts"
  homepage "https://github.com/abrignoni/DLEAPP"

  app "DLEAPP.app"
  binary "#{appdir}/DLEAPP.app/Contents/MacOS/dleapp"
end
