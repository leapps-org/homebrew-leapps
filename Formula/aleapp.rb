class Aleapp < Formula
  desc "Digital forensics tool for parsing Android backup files, images, and artifacts"
  homepage "https://github.com/abrignoni/aLEAPP"

  if Hardware::CPU.intel?
    url "https://github.com/abrignoni/ALEAPP/releases/download/v2026.3.0/aleapp-v2026.3.0-macOS_Mac_Intel.zip"
    sha256 "c470f80279abf7cbd2e3c8b1b10c599c039d48deafcbb6b7932cd7abc2318ca7"
  else
    url "https://github.com/abrignoni/ALEAPP/releases/download/v2026.3.0/aleapp-v2026.3.0-macOS_Apple_Silicon.zip"
    sha256 "275e4fe91bd995a396bfe65cc1b0d2a4404cffe5cddc03535452937d910aedb7"
  end

  def install
    bin.install "aleapp"
    chmod 0755, bin/"aleapp"
  end

  test do
    system "#{bin}/aleapp", "--version"
  end
end
