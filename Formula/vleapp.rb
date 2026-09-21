class Vleapp < Formula
  desc "Digital forensics tool for parsing vehicle infotainment system backup files, images, and artifacts"
  homepage "https://github.com/abrignoni/VLEAPP"

  if Hardware::CPU.intel?
    url "https://github.com/abrignoni/VLEAPP/releases/download/v2026.4.1/vleapp-v2026.4.1-macOS_Mac_Intel.zip"
    sha256 "b996e162680c6dfcda1ecd9db34bc03ec7738885f96b5c3dda4b31de7b0838c1"
  else
    url "https://github.com/abrignoni/VLEAPP/releases/download/v2026.4.1/vleapp-v2026.4.1-macOS_Apple_Silicon.zip"
    sha256 "72602b588fb0ee3c79eb7022ce8751eac02caefce0c5d4c02889683df6b690ac"
  end

  def install
    bin.install "vleapp"
    chmod 0755, bin/"vleapp"
  end

  test do
    system "#{bin}/vleapp", "--version"
  end
end
