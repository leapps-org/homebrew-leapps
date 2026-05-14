class Ileapp < Formula
  desc "Digital forensics tool for parsing iOS backup files, images, and artifacts"
  homepage "https://github.com/abrignoni/iLEAPP"

  if Hardware::CPU.intel?
    url "https://github.com/abrignoni/iLEAPP/releases/download/v2.3.1/ileapp-v2.3.1-Mac_Intel.zip"
    sha256 "0d5705635b5f99fa9299ce903502cfbc2b56fbbfc1bb762bbb178d5b1143e0b6"
  else
    url "https://github.com/abrignoni/iLEAPP/releases/download/v2.3.1/ileapp-v2.3.1-Apple_Silicon.zip"
    sha256 "0b0f364c08a80eade7c91ac65e82be5d962685a69e13062dae82a90134d1f8f5"
  end

  def install
    bin.install "ileapp"
    chmod 0755, bin/"ileapp"
  end

  test do
    system "#{bin}/ileapp", "--version"
  end
end
