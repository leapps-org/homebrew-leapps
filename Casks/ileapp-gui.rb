cask "ileapp-gui" do
  version "v2026.4.4"

  if Hardware::CPU.intel?
    url "https://github.com/abrignoni/iLEAPP/releases/download/v2026.4.4/iLEAPP-2026.4.4-macos-x64.dmg"
    sha256 "c44ed94e1ebde5444d15609ed1fde618d8b2875e066350bb7e8614ee2f215f1c"
  else
    url "https://github.com/abrignoni/iLEAPP/releases/download/v2026.4.4/iLEAPP-2026.4.4-macos-arm64.dmg"
    sha256 "0f3f99b6e93a0fac604466381b7a7da35d2b2126217f6b210e27e9b4543c7939"
  end

  name "iLEAPP"
  desc "Digital forensics tool for analyzing iOS artifacts"
  homepage "https://github.com/abrignoni/iLEAPP"

  app "iLEAPP.app"
  binary "#{appdir}/iLEAPP.app/Contents/MacOS/ileapp"
end
