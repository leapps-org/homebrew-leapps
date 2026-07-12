class Aleapp < Formula
  desc "Digital forensics tool for parsing Android backup files, images, and artifacts"
  homepage "https://github.com/abrignoni/aLEAPP"

  if Hardware::CPU.intel?
    url "https://github.com/abrignoni/ALEAPP/releases/download/v2026.1.0/aleapp-v2026.1.0-macOS_Mac_Intel.zip"
    sha256 "ca88f1ce227c4c817c5f4d4cd009ee1baf9963217dec2f300425f88eb6c8de2d"
  else
    url "https://github.com/abrignoni/ALEAPP/releases/download/v2026.1.0/aleapp-v2026.1.0-macOS_Apple_Silicon.zip"
    sha256 "4a46d48f782ec94f517b3794e3ef83a7f5ab5e26d95b20641fcf9d1efd30a3e0"
  end

  def install
    bin.install "aleapp"
    chmod 0755, bin/"aleapp"
  end

  test do
    system "#{bin}/aleapp", "--version"
  end
end
