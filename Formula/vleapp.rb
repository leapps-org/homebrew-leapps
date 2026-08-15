class Vleapp < Formula
  desc "Digital forensics tool for parsing vehicle infotainment system backup files, images, and artifacts"
  homepage "https://github.com/abrignoni/VLEAPP"

  if Hardware::CPU.intel?
    url "https://github.com/abrignoni/VLEAPP/releases/download/v2026.3.0/vleapp-v2026.3.0-macOS_Mac_Intel.zip"
    sha256 "567138b005fb987c6f74555e335e1708b4fb6b188ddcbe8bab933a8a339b1e70"
  else
    url "https://github.com/abrignoni/VLEAPP/releases/download/v2026.3.0/vleapp-v2026.3.0-macOS_Apple_Silicon.zip"
    sha256 "41ba1531cff76fb5aeb689c16cd15f79e18b6021c5712766191a7caa01d24eb1"
  end

  def install
    bin.install "vleapp"
    chmod 0755, bin/"vleapp"
  end

  test do
    system "#{bin}/vleapp", "--version"
  end
end
