class Rleapp < Formula
  desc "Digital forensics tool for parsing service provider warrant or data return files"
  homepage "https://github.com/abrignoni/RLEAPP"

  if Hardware::CPU.intel?
    url "https://github.com/abrignoni/RLEAPP/releases/download/v2026.3.1/rleapp-v2026.3.1-macOS_Mac_Intel.zip"
    sha256 "4b93701437ee5fa0069331fa181044a9dae3b2f2cd86cf5fa1d67e703bdbb8d8"
  else
    url "https://github.com/abrignoni/RLEAPP/releases/download/v2026.3.1/rleapp-v2026.3.1-macOS_Apple_Silicon.zip"
    sha256 "bf227be8a741ed05867d9b1d4b9493c89518caa14af6a0af9cd77994eeab125d"
  end

  def install
    bin.install "rleapp"
    chmod 0755, bin/"rleapp"
  end

  test do
    system "#{bin}/rleapp", "--version"
  end
end
