class Aleapp < Formula
  desc "Digital forensics tool for parsing Android backup files, images, and artifacts"
  homepage "https://github.com/abrignoni/aLEAPP"

  if Hardware::CPU.intel?
    url "https://github.com/abrignoni/aLEAPP/releases/download/v3.5.0/aleapp-v3.5.0-macOS_Mac_Intel.zip"
    sha256 "a6ccdc39cf6ac882c4cb0dabb4c9ed03311239bdfd6f76b6a2e835c2ff31f6c7"
  else
    url "https://github.com/abrignoni/aLEAPP/releases/download/v3.5.0/aleapp-v3.5.0-macOS_Apple_Silicon.zip"
    sha256 "42f293e926ba237c868d9838076563e4f22b5c2fd0285e7c3081f4d85b95ff47"
  end

  def install
    bin.install "aleapp"
    chmod 0755, bin/"aleapp"
  end

  test do
    system "#{bin}/aleapp", "--version"
  end
end
