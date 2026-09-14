class Rleapp < Formula
  desc "Digital forensics tool for parsing service provider warrant or data return files"
  homepage "https://github.com/abrignoni/RLEAPP"

  if Hardware::CPU.intel?
    url "https://github.com/abrignoni/RLEAPP/releases/download/v2026.4.0/rleapp-v2026.4.0-macOS_Mac_Intel.zip"
    sha256 "a678c68e7d368041bd1dc614a6e5d3d19494d4829cf9a481ef66e0dbf08cc44c"
  else
    url "https://github.com/abrignoni/RLEAPP/releases/download/v2026.4.0/rleapp-v2026.4.0-macOS_Apple_Silicon.zip"
    sha256 "2793552fe03d67d5b26129211953b3d49997e14750b9334bc1680c954a535030"
  end

  def install
    bin.install "rleapp"
    chmod 0755, bin/"rleapp"
  end

  test do
    system "#{bin}/rleapp", "--version"
  end
end
