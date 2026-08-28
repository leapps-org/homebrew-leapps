class Aleapp < Formula
  desc "Digital forensics tool for parsing Android backup files, images, and artifacts"
  homepage "https://github.com/abrignoni/aLEAPP"

  if Hardware::CPU.intel?
    url "https://github.com/abrignoni/ALEAPP/releases/download/v2026.3.2/aleapp-v2026.3.2-macOS_Mac_Intel.zip"
    sha256 "2fc967dddcdb821b07cfe12771a3049c01c20885aeb1b48093596c7e6b108a62"
  else
    url "https://github.com/abrignoni/ALEAPP/releases/download/v2026.3.2/aleapp-v2026.3.2-macOS_Apple_Silicon.zip"
    sha256 "8316d5cde606b20efb1f6837b8947f48464dc98260fef3eee86b0e2f19731d3b"
  end

  def install
    bin.install "aleapp"
    chmod 0755, bin/"aleapp"
  end

  test do
    system "#{bin}/aleapp", "--version"
  end
end
