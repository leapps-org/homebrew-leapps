class Ileapp < Formula
  desc "Digital forensics tool for parsing iOS backup files, images, and artifacts"
  homepage "https://github.com/abrignoni/iLEAPP"

  if Hardware::CPU.intel?
    url "https://github.com/abrignoni/iLEAPP/releases/download/v2026.3.3/ileapp-v2026.3.3-macOS_Mac_Intel.zip"
    sha256 "02aac39a5c69053c4dc3f287654f9e3f62c4469bd06e8e41e11a3c5264b916f5"
  else
    url "https://github.com/abrignoni/iLEAPP/releases/download/v2026.3.3/ileapp-v2026.3.3-macOS_Apple_Silicon.zip"
    sha256 "3626051b37bb55a06cc699b1a9ba5d029466f64f749f30da3b6fe05a659198bf"
  end

  def install
    bin.install "ileapp"
    chmod 0755, bin/"ileapp"
  end

  test do
    system "#{bin}/ileapp", "--version"
  end
end
