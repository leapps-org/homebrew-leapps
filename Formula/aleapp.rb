class Aleapp < Formula
  desc "Digital forensics tool for parsing Android backup files, images, and artifacts"
  homepage "https://github.com/abrignoni/aLEAPP"

  if Hardware::CPU.intel?
    url "https://github.com/abrignoni/ALEAPP/releases/download/v2026.3.3/aleapp-v2026.3.3-macOS_Mac_Intel.zip"
    sha256 "7de8a645a543c6e7f8478d5ce4afeca66b0438c6bbc1ba2bfb461a3367132d01"
  else
    url "https://github.com/abrignoni/ALEAPP/releases/download/v2026.3.3/aleapp-v2026.3.3-macOS_Apple_Silicon.zip"
    sha256 "228cbdbeaf882b29a01bf63d4ed478a5094008cde4ab68f5fde35c5a271d1578"
  end

  def install
    bin.install "aleapp"
    chmod 0755, bin/"aleapp"
  end

  test do
    system "#{bin}/aleapp", "--version"
  end
end
