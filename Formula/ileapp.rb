class Ileapp < Formula
  desc "Digital forensics tool for parsing iOS backup files, images, and artifacts"
  homepage "https://github.com/abrignoni/iLEAPP"

  if Hardware::CPU.intel?
    url "https://github.com/abrignoni/iLEAPP/releases/download/v2026.3.0/ileapp-v2026.3.0-macOS_Mac_Intel.zip"
    sha256 "52220bef9c251783cde63915f613535d8eab17d9d6e9e44b2488d5aac97d0cfe"
  else
    url "https://github.com/abrignoni/iLEAPP/releases/download/v2026.3.0/ileapp-v2026.3.0-macOS_Apple_Silicon.zip"
    sha256 "512214eb1dfe1579e66b4fde26de91ccefa80772e4d97d4c0e937523f73b1c38"
  end

  def install
    bin.install "ileapp"
    chmod 0755, bin/"ileapp"
  end

  test do
    system "#{bin}/ileapp", "--version"
  end
end
