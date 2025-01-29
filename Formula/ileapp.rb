class Ileapp < Formula
  desc "Digital forensics tool for parsing iOS backup files, images, and artifacts"
  homepage "https://github.com/abrignoni/iLEAPP"

  if Hardware::CPU.intel?
    url "https://github.com/abrignoni/iLEAPP/releases/download/v2.0.4/ileapp-v2.0.4-Mac_Intel.zip"
    sha256 "5c2bbcb044cbac55e008a4d46b9647a06e742365b2fdd7cb37e53bdc52b99dd6"
  else
    url "https://github.com/abrignoni/iLEAPP/releases/download/v2.0.4/ileapp-v2.0.4-Apple_Silicon.zip"
    sha256 "ee724cba72faf14231d03b0965fa097760181cd6618cecfb2caa4ba4c5182b1b"
  end

  def install
    bin.install "ileapp"
    chmod 0755, bin/"ileapp"
  end

  test do
    system "#{bin}/ileapp", "--version"
  end
end
