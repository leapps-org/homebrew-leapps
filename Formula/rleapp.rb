class Rleapp < Formula
  desc "Digital forensics tool for parsing service provider warrant or data return files"
  homepage "https://github.com/abrignoni/RLEAPP"

  if Hardware::CPU.intel?
    url "https://github.com/abrignoni/RLEAPP/releases/download/v2026.4.1/rleapp-v2026.4.1-macOS_Mac_Intel.zip"
    sha256 "714c06f4e4b46ee51b23ab1116f57404f7ae6282166b081b451a599c171eeed6"
  else
    url "https://github.com/abrignoni/RLEAPP/releases/download/v2026.4.1/rleapp-v2026.4.1-macOS_Apple_Silicon.zip"
    sha256 "ed6ae56593cc27ff3c283d94e3a754511b8b7795d92089858d4e1166cce40c3a"
  end

  def install
    bin.install "rleapp"
    chmod 0755, bin/"rleapp"
  end

  test do
    system "#{bin}/rleapp", "--version"
  end
end
