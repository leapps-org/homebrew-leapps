class Ileapp < Formula
  desc "Digital forensics tool for parsing iOS backup files, images, and artifacts"
  homepage "https://github.com/abrignoni/iLEAPP"

  if Hardware::CPU.intel?
    url "https://github.com/abrignoni/iLEAPP/releases/download/v2026.2.0/ileapp-v2026.2.0-macOS_Mac_Intel.zip"
    sha256 "f0739af77324db30d878c72cf426450ba999ae5404fdaa230465843c2e712dfb"
  else
    url "https://github.com/abrignoni/iLEAPP/releases/download/v2026.2.0/ileapp-v2026.2.0-macOS_Apple_Silicon.zip"
    sha256 "fa06c0bf0b7ae263cba671d6909a59d434fb6c1743a8ca12dd62685c4b6c7292"
  end

  def install
    bin.install "ileapp"
    chmod 0755, bin/"ileapp"
  end

  test do
    system "#{bin}/ileapp", "--version"
  end
end
