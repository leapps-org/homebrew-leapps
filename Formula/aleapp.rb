class Aleapp < Formula
  desc "Digital forensics tool for parsing Android backup files, images, and artifacts"
  homepage "https://github.com/abrignoni/aLEAPP"

  if Hardware::CPU.intel?
    url "https://github.com/abrignoni/ALEAPP/releases/download/v2026.4.1/aleapp-v2026.4.1-macOS_Mac_Intel.zip"
    sha256 "dde43304acce737032b803b2a92ad0b225c64c6f37c743aab2c6a4a61eecb754"
  else
    url "https://github.com/abrignoni/ALEAPP/releases/download/v2026.4.1/aleapp-v2026.4.1-macOS_Apple_Silicon.zip"
    sha256 "2829b69c0f9035035d95936ee0a5168674fa6f4ffde01706ee3c6c1d2ecaf7f0"
  end

  def install
    bin.install "aleapp"
    chmod 0755, bin/"aleapp"
  end

  test do
    system "#{bin}/aleapp", "--version"
  end
end
