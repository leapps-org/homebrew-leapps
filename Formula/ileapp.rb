class Ileapp < Formula
  desc "Digital forensics tool for parsing iOS backup files, images, and artifacts"
  homepage "https://github.com/abrignoni/iLEAPP"

  if Hardware::CPU.intel?
    url "https://github.com/abrignoni/iLEAPP/releases/download/v2.2.0/ileapp-v2.2.0-Mac_Intel.zip"
    sha256 "1cba91616fca7efff412d4c55e2baaf8248aae5714b9fc4f6a1d4fb5b667fa39"
  else
    url "https://github.com/abrignoni/iLEAPP/releases/download/v2.2.0/ileapp-v2.2.0-Apple_Silicon.zip"
    sha256 "8e163e390e8276b54008a28258c62de4f8b3acabc18aedd385893f0ec8cfc55c"
  end

  def install
    bin.install "ileapp"
    chmod 0755, bin/"ileapp"
  end

  test do
    system "#{bin}/ileapp", "--version"
  end
end
