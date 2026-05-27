class Ileapp < Formula
  desc "Digital forensics tool for parsing iOS backup files, images, and artifacts"
  homepage "https://github.com/abrignoni/iLEAPP"

  if Hardware::CPU.intel?
    url "https://github.com/abrignoni/iLEAPP/releases/download/v2.5.0/ileapp-v2.5.0-macOS_Mac_Intel.zip"
    sha256 "45b16c8348aefc4a27fb49e023ec51acf151ba6e4162179235f754938eb79d29"
  else
    url "https://github.com/abrignoni/iLEAPP/releases/download/v2.5.0/ileapp-v2.5.0-macOS_Apple_Silicon.zip"
    sha256 "9214d5d2cc171ba99568bcf317cd5549c28871a9064e951f1cb85a3612de3134"
  end

  def install
    bin.install "ileapp"
    chmod 0755, bin/"ileapp"
  end

  test do
    system "#{bin}/ileapp", "--version"
  end
end
