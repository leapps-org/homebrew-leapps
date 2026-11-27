cask "gleapp" do
  version "v2026.5.9"

  if Hardware::CPU.intel?
    url "https://github.com/abrignoni/GLEAPP/releases/download/v2026.5.9/GLEAPP-2026.5.9-macos-x64.dmg"
    sha256 "999af234224f3d9b1d556b33236fb106bab3ee6ece8362164edc4e13f90c2ada"
  else
    url "https://github.com/abrignoni/GLEAPP/releases/download/v2026.5.9/GLEAPP-2026.5.9-macos-arm64.dmg"
    sha256 "4d2225ee0d1e057758a9856c132d508b241b595b0f5b88f9675c692c0c026286"
  end

  name "GLEAPP"
  desc "Image and video forensic triage toolkit"
  homepage "https://github.com/abrignoni/GLEAPP"

  app "GLEAPP.app"
  binary "#{appdir}/GLEAPP.app/Contents/MacOS/GLEAPP", target: "gleapp"
end
