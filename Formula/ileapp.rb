class Ileapp < Formula
  desc "Digital forensics tool for parsing iOS backup files, images, and artifacts"
  homepage "https://github.com/abrignoni/iLEAPP"

  if Hardware::CPU.intel?
    url "https://github.com/abrignoni/iLEAPP/releases/download/v2.0.1/ileapp-2.0.1-Mac_Intel.zip"
    sha256 "c32986d4ac8e3af19a9d6cc7ccccddd5cec38a489257bf25c45d865ceeb1ba86"
  else
    url "https://github.com/abrignoni/iLEAPP/releases/download/v2.0.1/ileapp-2.0.1-Apple_Silicon.zip"
    sha256 "ff2622f6411facde1d84b53071331922be93c38e0ea552380e5420215e5a4c06"
  end

  def install
    bin.install "ileapp"
    chmod 0755, bin/"ileapp"
  end

  test do
    system "#{bin}/ileapp", "--version"
  end
end
