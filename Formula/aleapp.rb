class Aleapp < Formula
  desc "Digital forensics tool for parsing Android backup files, images, and artifacts"
  homepage "https://github.com/abrignoni/aLEAPP"

  if Hardware::CPU.intel?
    url "https://github.com/abrignoni/aLEAPP/releases/download/v3.6.0/aleapp-v3.6.0-macOS_Mac_Intel.zip"
    sha256 "79d4235099dc8ba0122cb735f9be4e6e59a86c3c238fe5a8f18d5f1d63958c91"
  else
    url "https://github.com/abrignoni/aLEAPP/releases/download/v3.6.0/aleapp-v3.6.0-macOS_Apple_Silicon.zip"
    sha256 "322e36e3de7b9b843c9918ddf2789f7536145cd5a6043d1aee7a148daaf9c521"
  end

  def install
    bin.install "aleapp"
    chmod 0755, bin/"aleapp"
  end

  test do
    system "#{bin}/aleapp", "--version"
  end
end
