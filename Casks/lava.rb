cask "lava" do
  version "v0.14.0"

  if Hardware::CPU.intel?
    url "https://github.com/leapps-org/LAVA-releases/releases/download/v0.14.0/LAVA-0.14.0-macOS-Mac_Intel.dmg"
    sha256 "cd9126115f1f5ed9f6c19f537f84b12b92aa9ddaae0e56e973b16fe850d45d0b"
  else
    url "https://github.com/leapps-org/LAVA-releases/releases/download/v0.14.0/LAVA-0.14.0-macOS-Apple_Silicon.dmg"
    sha256 "902aea14c3bc4b64b4dd0741c42adaa26a9d993bbd9dfb87bde92ad888b2f3ea"
  end

  name "LAVA"
  desc "LEAPP Artifact Viewer App for reviewing and exploring LEAPP output"
  homepage "https://github.com/leapps-org/LAVA-releases"

  app "LAVA.app"
end
