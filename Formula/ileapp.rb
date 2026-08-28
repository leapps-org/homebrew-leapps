class Ileapp < Formula
  desc "Digital forensics tool for parsing iOS backup files, images, and artifacts"
  homepage "https://github.com/abrignoni/iLEAPP"

  if Hardware::CPU.intel?
    url "https://github.com/abrignoni/iLEAPP/releases/download/v2026.3.2/ileapp-v2026.3.2-macOS_Mac_Intel.zip"
    sha256 "b2c343ca807b8c4bb1738a12008008523661902926f7c7f51113b0be238336ba"
  else
    url "https://github.com/abrignoni/iLEAPP/releases/download/v2026.3.2/ileapp-v2026.3.2-macOS_Apple_Silicon.zip"
    sha256 "eb9fd1ebe997cc8a7858bb3f8a69f73e7504676c7ac246326a206b804c0331f5"
  end

  def install
    bin.install "ileapp"
    chmod 0755, bin/"ileapp"
  end

  test do
    system "#{bin}/ileapp", "--version"
  end
end
