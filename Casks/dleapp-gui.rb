cask "dleapp-gui" do
  version "v2026.4.4"

  if Hardware::CPU.intel?
    url "https://github.com/abrignoni/DLEAPP/releases/download/v2026.4.4/DLEAPP-2026.4.4-macos-x64.dmg"
    sha256 "e6239788b355cc55f77ed20df4f25af722968d2dd6aa71756ad4f28203e115e2"
  else
    url "https://github.com/abrignoni/DLEAPP/releases/download/v2026.4.4/DLEAPP-2026.4.4-macos-arm64.dmg"
    sha256 "98efe3fc60396353389ffb6a11538161a9d07e22e97026afc43428617d89e1db"
  end

  name "DLEAPP"
  desc "Digital forensics tool for analyzing desktop computer artifacts"
  homepage "https://github.com/abrignoni/DLEAPP"

  app "DLEAPP.app"
  binary "#{appdir}/DLEAPP.app/Contents/MacOS/dleapp"
end
