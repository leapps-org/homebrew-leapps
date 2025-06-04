class Aleapp < Formula
  desc "Digital forensics tool for parsing Android backup files, images, and artifacts"
  homepage "https://github.com/abrignoni/aLEAPP"

  if Hardware::CPU.intel?
    url "https://github.com/abrignoni/aLEAPP/releases/download/v3.4.0/aleapp-v3.4.0-Mac_Intel.zip"
    sha256 "0a1188bbe9f94a77a24c1f5dc7ff804e24e266f1ceaf13958e92ac4eb391d1a3"
  else
    url "https://github.com/abrignoni/aLEAPP/releases/download/v3.4.0/aleapp-v3.4.0-Apple_Silicon.zip"
    sha256 "96ddf4b8d0efe645e21750ccf6c270dec9926f01a2e15b262bcd29b42c454ba3"
  end

  def install
    bin.install "aleapp"
    chmod 0755, bin/"aleapp"
  end

  test do
    system "#{bin}/aleapp", "--version"
  end
end
