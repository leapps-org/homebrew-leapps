cask "lava" do
  version "v0.15.0"

  if Hardware::CPU.intel?
    url "https://github.com/leapps-org/LAVA-releases/releases/download/v0.15.0/LAVA-0.15.0-macOS-Mac_Intel.dmg"
    sha256 "7d43b0c641a08592da97824bd3a4fc045c69d211fe6957b1ce901054bf82154b"
  else
    url "https://github.com/leapps-org/LAVA-releases/releases/download/v0.15.0/LAVA-0.15.0-macOS-Apple_Silicon.dmg"
    sha256 "56310d197e125b673083066575980816ddcf42eeb9c365eae56e94ba7a045c18"
  end

  name "LAVA"
  desc "LEAPP Artifact Viewer App for reviewing and exploring LEAPP output"
  homepage "https://github.com/leapps-org/LAVA-releases"

  app "LAVA.app"
end
