class Ileapp < Formula
  desc "Digital forensics tool for parsing iOS backup files, images, and artifacts"
  homepage "https://github.com/abrignoni/iLEAPP"

  if Hardware::CPU.intel?
    url "https://github.com/abrignoni/iLEAPP/releases/download/v2.1.0/ileapp-v2.1.0-Mac_Intel.zip"
    sha256 "667dd2dd7c2ad367e08b5de9a25a7d27b739883809ac44a709e103eace57c681"
  else
    url "https://github.com/abrignoni/iLEAPP/releases/download/v2.1.0/ileapp-v2.1.0-Apple_Silicon.zip"
    sha256 "9b1b9d992cae925185e794b0435c4649e4e47219ca516939859150224e3837f4"
  end

  def install
    bin.install "ileapp"
    chmod 0755, bin/"ileapp"
  end

  test do
    system "#{bin}/ileapp", "--version"
  end
end
