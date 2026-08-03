class Rleapp < Formula
  desc "Digital forensics tool for parsing service provider warrant or data return files"
  homepage "https://github.com/abrignoni/RLEAPP"

  if Hardware::CPU.intel?
    url "https://github.com/abrignoni/RLEAPP/releases/download/v2026.2.0/rleapp-v2026.2.0-macOS_Mac_Intel.zip"
    sha256 "29eade7a757a83d5ba9dc02cd2b9feea679a95de1a443e82905635ca13be60f0"
  else
    url "https://github.com/abrignoni/RLEAPP/releases/download/v2026.2.0/rleapp-v2026.2.0-macOS_Apple_Silicon.zip"
    sha256 "c1807bf0d1e4514154d2987a57b95c82ac9b321473751f624d7a790523621430"
  end

  def install
    bin.install "rleapp"
    chmod 0755, bin/"rleapp"
  end

  test do
    system "#{bin}/rleapp", "--version"
  end
end
