cask "gleapp" do
  version "v2026.5.6"

  if Hardware::CPU.intel?
    url "https://github.com/abrignoni/GLEAPP/releases/download/v2026.5.6/GLEAPP-2026.5.6-macos-x64.dmg"
    sha256 "7a8de82c39ceb5cd3353ed02e56fc8f23bd659b5b8d59119633c5972da759940"
  else
    url "https://github.com/abrignoni/GLEAPP/releases/download/v2026.5.6/GLEAPP-2026.5.6-macos-arm64.dmg"
    sha256 "8485e3adc612ddc38415c216f352ccd7ae1224bbf1c8422777318af675838a03"
  end

  name "GLEAPP"
  desc "Image and video forensic triage toolkit"
  homepage "https://github.com/abrignoni/GLEAPP"

  app "GLEAPP.app"
end
