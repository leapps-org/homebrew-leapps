class Ileapp < Formula
  desc "Digital forensics tool for parsing iOS backup files, images, and artifacts"
  homepage "https://github.com/abrignoni/iLEAPP"

  if Hardware::CPU.intel?
    url "https://github.com/abrignoni/iLEAPP/releases/download/v2026.4.0/ileapp-v2026.4.0-macOS_Mac_Intel.zip"
    sha256 "4c2399941ba69e3fe760a208fbab61c49d68b7ce59a45075a311b83def42483e"
  else
    url "https://github.com/abrignoni/iLEAPP/releases/download/v2026.4.0/ileapp-v2026.4.0-macOS_Apple_Silicon.zip"
    sha256 "07944994e7415347f601045d8eea2085722543c9c45c4c57b58a0a29a240b789"
  end

  def install
    bin.install "ileapp"
    chmod 0755, bin/"ileapp"
  end

  test do
    system "#{bin}/ileapp", "--version"
  end
end
