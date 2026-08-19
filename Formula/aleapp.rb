class Aleapp < Formula
  desc "Digital forensics tool for parsing Android backup files, images, and artifacts"
  homepage "https://github.com/abrignoni/aLEAPP"

  if Hardware::CPU.intel?
    url "https://github.com/abrignoni/ALEAPP/releases/download/v2026.3.1/aleapp-v2026.3.1-macOS_Mac_Intel.zip"
    sha256 "a15ec51f251fd419770ad250231351b22ae7c1f874b9c20ce481e8326b4f6fad"
  else
    url "https://github.com/abrignoni/ALEAPP/releases/download/v2026.3.1/aleapp-v2026.3.1-macOS_Apple_Silicon.zip"
    sha256 "d81a2e60d2b26e95f44b22c173546005b629e74c7f5d12c4462c307ac4c6b2fe"
  end

  def install
    bin.install "aleapp"
    chmod 0755, bin/"aleapp"
  end

  test do
    system "#{bin}/aleapp", "--version"
  end
end
