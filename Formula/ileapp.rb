class Ileapp < Formula
  desc "Digital forensics tool for parsing iOS backup files, images, and artifacts"
  homepage "https://github.com/abrignoni/iLEAPP"

  if Hardware::CPU.intel?
    url "https://github.com/abrignoni/iLEAPP/releases/download/v2026.4.1/ileapp-v2026.4.1-macOS_Mac_Intel.zip"
    sha256 "d4ba47a265bf5989fd1a39126077e086b9c3982f1db5da3a677122391401fba8"
  else
    url "https://github.com/abrignoni/iLEAPP/releases/download/v2026.4.1/ileapp-v2026.4.1-macOS_Apple_Silicon.zip"
    sha256 "d6e5bff7e3e916f066a7d9df7f57a926c1d6b4ce6add0c726cf74e3e672b01f0"
  end

  def install
    bin.install "ileapp"
    chmod 0755, bin/"ileapp"
  end

  test do
    system "#{bin}/ileapp", "--version"
  end
end
