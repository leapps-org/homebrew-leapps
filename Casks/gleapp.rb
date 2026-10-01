cask "gleapp" do
  version "v2026.5.3"

  if Hardware::CPU.intel?
    url "https://github.com/abrignoni/GLEAPP/releases/download/v2026.5.3/GLEAPP-2026.5.3-macos-x64.dmg"
    sha256 "54971ef5d592433409202662a9d3584320ce95fceeceb4c7d116cf22c656b549"
  else
    url "https://github.com/abrignoni/GLEAPP/releases/download/v2026.5.3/GLEAPP-2026.5.3-macos-arm64.dmg"
    sha256 "c60d4ff0a21ce0f1ac5fe8d22a28c66ce0060ca5e7e47914747f31eac1043d5a"
  end

  name "GLEAPP"
  desc "Image and video forensic triage toolkit"
  homepage "https://github.com/abrignoni/GLEAPP"

  app "GLEAPP.app"
end
