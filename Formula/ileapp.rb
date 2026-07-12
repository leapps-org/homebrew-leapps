class Ileapp < Formula
  desc "Digital forensics tool for parsing iOS backup files, images, and artifacts"
  homepage "https://github.com/abrignoni/iLEAPP"

  if Hardware::CPU.intel?
    url "https://github.com/abrignoni/iLEAPP/releases/download/v2026.1.0/ileapp-v2026.1.0-macOS_Mac_Intel.zip"
    sha256 "158325e715d0855328f4f61ed1fa9511c1e3cc89f434a4a696bed6623c4f8b51"
  else
    url "https://github.com/abrignoni/iLEAPP/releases/download/v2026.1.0/ileapp-v2026.1.0-macOS_Apple_Silicon.zip"
    sha256 "e734abf0dfe53c38d59e3b251a2e0dda726ca863382ade0d412c38459db6e38f"
  end

  def install
    bin.install "ileapp"
    chmod 0755, bin/"ileapp"
  end

  test do
    system "#{bin}/ileapp", "--version"
  end
end
