class Ileapp < Formula
  desc "Digital forensics tool for parsing iOS backup files, images, and artifacts"
  homepage "https://github.com/abrignoni/iLEAPP"

  if Hardware::CPU.intel?
    url "https://github.com/abrignoni/iLEAPP/releases/download/v2026.2.1/ileapp-v2026.2.1-macOS_Mac_Intel.zip"
    sha256 "ce14d34b3c570c536261462d9225bab0ae1a5b2de411dbd1428cc33da24a107a"
  else
    url "https://github.com/abrignoni/iLEAPP/releases/download/v2026.2.1/ileapp-v2026.2.1-macOS_Apple_Silicon.zip"
    sha256 "084e78406a1a76576bb673669e8482f3c2ea253e836ff7098c061ab4f5a274e6"
  end

  def install
    bin.install "ileapp"
    chmod 0755, bin/"ileapp"
  end

  test do
    system "#{bin}/ileapp", "--version"
  end
end
