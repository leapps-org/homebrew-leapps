cask "lava" do
  version "v2026.1.0"

  if Hardware::CPU.intel?
    url "https://github.com/leapps-org/LAVA-releases/releases/download/v2026.1.0/LAVA-2026.1.0-macOS-Mac_Intel.dmg"
    sha256 "dd07dff8728c974e68822b424d684abadaa4c2e9d786917450a410d41ed6c37e"
  else
    url "https://github.com/leapps-org/LAVA-releases/releases/download/v2026.1.0/LAVA-2026.1.0-macOS-Apple_Silicon.dmg"
    sha256 "f59062c443a1e7bd9d3bf0d6d1a5bf155dc36071a693935691ba56c12bd12064"
  end

  name "LAVA"
  desc "LEAPP Artifact Viewer App for reviewing and exploring LEAPP output"
  homepage "https://github.com/leapps-org/LAVA-releases"

  app "LAVA.app"
end
