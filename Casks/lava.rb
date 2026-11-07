cask "lava" do
  version "v2026.1.1"

  if Hardware::CPU.intel?
    url "https://github.com/leapps-org/LAVA-releases/releases/download/v2026.1.1/LAVA-2026.1.1-macOS-Mac_Intel.dmg"
    sha256 "ecf3ea1e4f6e52fad45ed30ecf484d26da68640f6710c67659dbb4d733b217d5"
  else
    url "https://github.com/leapps-org/LAVA-releases/releases/download/v2026.1.1/LAVA-2026.1.1-macOS-Apple_Silicon.dmg"
    sha256 "ff4654e820fa35094883ff6813703b16bc89fe71463d9efe42debbdb1d7b4b49"
  end

  name "LAVA"
  desc "LEAPP Artifact Viewer App for reviewing and exploring LEAPP output"
  homepage "https://github.com/leapps-org/LAVA-releases"

  app "LAVA.app"
end
