cask "aleapp" do
  version "v2026.4.6"

  if Hardware::CPU.intel?
    url "https://github.com/abrignoni/ALEAPP/releases/download/v2026.4.6/ALEAPP-2026.4.6-macos-x64.dmg"
    sha256 "a1484098cb64f5a5d9541e497808748c0c459c74280ac912dcf05cd264c60d77"
  else
    url "https://github.com/abrignoni/ALEAPP/releases/download/v2026.4.6/ALEAPP-2026.4.6-macos-arm64.dmg"
    sha256 "cf755433eaa0f0c50d91d30217797a5dbbca41efb6dafac9b29c50329ea351ba"
  end

  name "ALEAPP"
  desc "Digital forensics tool for parsing Android backup files, images, and artifacts"
  homepage "https://github.com/abrignoni/ALEAPP"

  app "ALEAPP.app"
  binary "#{appdir}/ALEAPP.app/Contents/MacOS/aleapp"
end
