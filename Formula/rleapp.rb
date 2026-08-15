class Rleapp < Formula
  desc "Digital forensics tool for parsing service provider warrant or data return files"
  homepage "https://github.com/abrignoni/RLEAPP"

  if Hardware::CPU.intel?
    url "https://github.com/abrignoni/RLEAPP/releases/download/v2026.3.0/rleapp-v2026.3.0-macOS_Mac_Intel.zip"
    sha256 "852d0683daab8fa6ab6e95deb8021d1a14b09c67a8240b7019279541d0a921dd"
  else
    url "https://github.com/abrignoni/RLEAPP/releases/download/v2026.3.0/rleapp-v2026.3.0-macOS_Apple_Silicon.zip"
    sha256 "0198dd8f2d8d3c1c3b2fac6410d8b84ef56f60eacedf85ace57125fb7ca5a62f"
  end

  def install
    bin.install "rleapp"
    chmod 0755, bin/"rleapp"
  end

  test do
    system "#{bin}/rleapp", "--version"
  end
end
