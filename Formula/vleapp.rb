class Vleapp < Formula
  desc "Digital forensics tool for parsing vehicle infotainment system backup files, images, and artifacts"
  homepage "https://github.com/abrignoni/VLEAPP"

  if Hardware::CPU.intel?
    url "https://github.com/abrignoni/VLEAPP/releases/download/v2026.2.0/vleapp-v2026.2.0-macOS_Mac_Intel.zip"
    sha256 "0bf7f14507332573625dab082a88a3bf4c32df7fa90347a1dba4f1d46008d21a"
  else
    url "https://github.com/abrignoni/VLEAPP/releases/download/v2026.2.0/vleapp-v2026.2.0-macOS_Apple_Silicon.zip"
    sha256 "da32054419f1b3133a153446d62d35bd4c6350f68c5165cb8bda17335cc1aeee"
  end

  def install
    bin.install "vleapp"
    chmod 0755, bin/"vleapp"
  end

  test do
    system "#{bin}/vleapp", "--version"
  end
end
