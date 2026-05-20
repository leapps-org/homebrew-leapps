class Ileapp < Formula
  desc "Digital forensics tool for parsing iOS backup files, images, and artifacts"
  homepage "https://github.com/abrignoni/iLEAPP"

  if Hardware::CPU.intel?
    url "https://github.com/abrignoni/iLEAPP/releases/download/v2.4.0/ileapp-v2.4.0-macOS_Mac_Intel.zip"
    sha256 "ec7b2fa2b0be6cc90f2d884b53093da11ebc7adb33418d6bbfcabaee8039e5ef"
  else
    url "https://github.com/abrignoni/iLEAPP/releases/download/v2.4.0/ileapp-v2.4.0-macOS_Apple_Silicon.zip"
    sha256 "35ded8b02fca6c5c13408c9e4d518936430f3c60240b738936c1356063907534"
  end

  def install
    bin.install "ileapp"
    chmod 0755, bin/"ileapp"
  end

  test do
    system "#{bin}/ileapp", "--version"
  end
end
