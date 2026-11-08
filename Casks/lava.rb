cask "lava" do
  version "v2026.1.2"

  if Hardware::CPU.intel?
    url "https://github.com/leapps-org/LAVA-releases/releases/download/v2026.1.2/LAVA-2026.1.2-macOS-Mac_Intel.dmg"
    sha256 "fc2f4b28690d96ed52fe96d49f747365c8b802b5544b5b24ace91dc8db5ff505"
  else
    url "https://github.com/leapps-org/LAVA-releases/releases/download/v2026.1.2/LAVA-2026.1.2-macOS-Apple_Silicon.dmg"
    sha256 "8d38ffe247a21d0b76a90aca8ff9005035210ba4faa63788a7c40729c50671df"
  end

  name "LAVA"
  desc "LEAPP Artifact Viewer App for reviewing and exploring LEAPP output"
  homepage "https://github.com/leapps-org/LAVA-releases"

  app "LAVA.app"
end
