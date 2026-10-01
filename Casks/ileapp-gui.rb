cask "ileapp-gui" do
  version "v2026.4.3"

  if Hardware::CPU.intel?
    url "https://github.com/abrignoni/iLEAPP/releases/download/v2026.4.3/iLEAPP-2026.4.3-macos-x64.dmg"
    sha256 "fe8ad225b0276d6a03800619526e0e6b3fe12d6563be10773bdc731260c0b0f6"
  else
    url "https://github.com/abrignoni/iLEAPP/releases/download/v2026.4.3/iLEAPP-2026.4.3-macos-arm64.dmg"
    sha256 "8ef81c22b477157de838b60e4529866fbb0ce635d8d69399969557b3100ae58f"
  end

  name "iLEAPP"
  desc "Digital forensics tool for analyzing iOS artifacts"
  homepage "https://github.com/abrignoni/iLEAPP"

  app "iLEAPP.app"
  binary "#{appdir}/iLEAPP.app/Contents/MacOS/ileapp"
end
