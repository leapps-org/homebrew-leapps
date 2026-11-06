cask "rleapp" do
  version "v2026.4.5"

  if Hardware::CPU.intel?
    url "https://github.com/abrignoni/RLEAPP/releases/download/v2026.4.5/RLEAPP-2026.4.5-macos-x64.dmg"
    sha256 "6efefe4f2619e0f4d354f901885da2e6cc7b1e9902069517d050c261d6015b83"
  else
    url "https://github.com/abrignoni/RLEAPP/releases/download/v2026.4.5/RLEAPP-2026.4.5-macos-arm64.dmg"
    sha256 "2ab967b140b9a46cb305ae4fd33c3c3f943305330f22a3a326578b412552ed07"
  end

  name "RLEAPP"
  desc "Digital forensics tool for parsing service provider warrant or data return files"
  homepage "https://github.com/abrignoni/RLEAPP"

  app "RLEAPP.app"
  binary "#{appdir}/RLEAPP.app/Contents/MacOS/rleapp"
end
