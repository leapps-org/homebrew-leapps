cask "dleapp" do
  version "v2026.4.6"

  if Hardware::CPU.intel?
    url "https://github.com/abrignoni/DLEAPP/releases/download/v2026.4.6/DLEAPP-2026.4.6-macos-x64.dmg"
    sha256 "9db7d25b46f858a3eddab48558b10bcd0d5f34843cf1509d42fd3f8881c1256d"
  else
    url "https://github.com/abrignoni/DLEAPP/releases/download/v2026.4.6/DLEAPP-2026.4.6-macos-arm64.dmg"
    sha256 "a067ab303862d937e26e7c0f92ce1301da4b3745f3bfe0739847aa4938ae1fe5"
  end

  name "DLEAPP"
  desc "Digital forensics tool for parsing desktop operating system artifacts"
  homepage "https://github.com/abrignoni/DLEAPP"

  app "DLEAPP.app"
  binary "#{appdir}/DLEAPP.app/Contents/MacOS/dleapp"
end
