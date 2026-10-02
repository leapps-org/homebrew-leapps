cask "aleapp-gui" do
  version "v2026.4.3"

  if Hardware::CPU.intel?
    url "https://github.com/abrignoni/ALEAPP/releases/download/v2026.4.3/ALEAPP-2026.4.3-macos-x64.dmg"
    sha256 "70b84e0bffa3cf4ecd94503d109a0e5575c05c134645186f6bd520937fbfab18"
  else
    url "https://github.com/abrignoni/ALEAPP/releases/download/v2026.4.3/ALEAPP-2026.4.3-macos-arm64.dmg"
    sha256 "05aa019a8bc68208e0611f829289a236c51c66caf3a00780aeb20194c15c4125"
  end

  name "ALEAPP"
  desc "Digital forensics tool for analyzing Android artifacts"
  homepage "https://github.com/abrignoni/ALEAPP"

  app "ALEAPP.app"
  binary "#{appdir}/ALEAPP.app/Contents/MacOS/aleapp"
end
