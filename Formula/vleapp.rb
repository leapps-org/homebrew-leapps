class Vleapp < Formula
  desc "Digital forensics tool for parsing vehicle infotainment system backup files, images, and artifacts"
  homepage "https://github.com/abrignoni/VLEAPP"

  if Hardware::CPU.intel?
    url "https://github.com/abrignoni/VLEAPP/releases/download/v2026.3.2/vleapp-v2026.3.2-macOS_Mac_Intel.zip"
    sha256 "887fa36c5bdbfac6fa2ad9e0484c2e968c729eea1df3f917d750ecc15905f0c5"
  else
    url "https://github.com/abrignoni/VLEAPP/releases/download/v2026.3.2/vleapp-v2026.3.2-macOS_Apple_Silicon.zip"
    sha256 "dc56d894e57ab466b40954f9f9feab8dd1403310ac6c7728702c1d341966d4f0"
  end

  def install
    bin.install "vleapp"
    chmod 0755, bin/"vleapp"
  end

  test do
    system "#{bin}/vleapp", "--version"
  end
end
