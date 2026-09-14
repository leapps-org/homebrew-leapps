class Aleapp < Formula
  desc "Digital forensics tool for parsing Android backup files, images, and artifacts"
  homepage "https://github.com/abrignoni/aLEAPP"

  if Hardware::CPU.intel?
    url "https://github.com/abrignoni/ALEAPP/releases/download/v2026.4.0/aleapp-v2026.4.0-macOS_Mac_Intel.zip"
    sha256 "56b599f228f01afd28d60154e0194973f47d8d7a8d721a2255c15a320f30c73d"
  else
    url "https://github.com/abrignoni/ALEAPP/releases/download/v2026.4.0/aleapp-v2026.4.0-macOS_Apple_Silicon.zip"
    sha256 "9169d030b01d44d149458d707d7670329091f0e61ebd5f422ebb6e435f4d5d6e"
  end

  def install
    bin.install "aleapp"
    chmod 0755, bin/"aleapp"
  end

  test do
    system "#{bin}/aleapp", "--version"
  end
end
