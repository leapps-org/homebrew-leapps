class Ileapp < Formula
  desc "Digital forensics tool for parsing iOS backup files, images, and artifacts"
  homepage "https://github.com/abrignoni/iLEAPP"

  if Hardware::CPU.intel?
    url "https://github.com/abrignoni/iLEAPP/releases/download/v2.0.2/ileapp-v2.0.2-Mac_Intel.zip"
    sha256 "1a2fc616f48a5499ae04b0c5d9beab0912b278d3b09bf3e5ce0650d67394e5c8"
  else
    url "https://github.com/abrignoni/iLEAPP/releases/download/v2.0.2/ileapp-v2.0.2-Apple_Silicon.zip"
    sha256 "4bba124a84e475cae32241223714024ee121ed8579a82ac4ae2a8b7e71743e7c"
  end

  def install
    bin.install "ileapp"
    chmod 0755, bin/"ileapp"
  end

  test do
    system "#{bin}/ileapp", "--version"
  end
end
