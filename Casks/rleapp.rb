cask "rleapp" do
  version "v2026.5.0"

  if Hardware::CPU.intel?
    url "https://github.com/abrignoni/RLEAPP/releases/download/v2026.5.0/RLEAPP-2026.5.0-macos-x64.dmg"
    sha256 "e9de673444c21e4399f60cc19fd13f47639e42abb2972c209c4203a7287ce46b"
  else
    url "https://github.com/abrignoni/RLEAPP/releases/download/v2026.5.0/RLEAPP-2026.5.0-macos-arm64.dmg"
    sha256 "14ffb2dc75f78c2f91f7d312d56ed0353175ff7557db0980d8c535f63f428caf"
  end

  name "RLEAPP"
  desc "Digital forensics tool for parsing service provider warrant or data return files"
  homepage "https://github.com/abrignoni/RLEAPP"

  app "RLEAPP.app"
  binary "#{appdir}/RLEAPP.app/Contents/MacOS/rleapp"
end
