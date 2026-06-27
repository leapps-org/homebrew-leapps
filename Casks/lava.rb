cask "lava" do
  version "v0.13.0"

  if Hardware::CPU.intel?
    url "https://github.com/leapps-org/LAVA-releases/releases/download/v0.13.0/LAVA-0.13.0-macOS-Mac_Intel.dmg"
    sha256 "ba1a2a21f1bf39f6cd040e3086ad14a15390d51988618152935376e1ee29b1d3"
  else
    url "https://github.com/leapps-org/LAVA-releases/releases/download/v0.13.0/LAVA-0.13.0-macOS-Apple_Silicon.dmg"
    sha256 "ce2b340ca1ca7f101e023b82aaeebcdfabd86f24e0cdd3dfc49628008b4d2cad"
  end

  name "LAVA"
  desc "LEAPP Artifact Viewer App for reviewing and exploring LEAPP output"
  homepage "https://github.com/leapps-org/LAVA-releases"

  app "LAVA.app"
end
