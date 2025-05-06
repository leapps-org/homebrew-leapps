class Ileapp < Formula
  desc "Digital forensics tool for parsing iOS backup files, images, and artifacts"
  homepage "https://github.com/abrignoni/iLEAPP"

  if Hardware::CPU.intel?
    url "https://github.com/abrignoni/iLEAPP/releases/download/v2.1.3/ileapp-v2.1.3-Mac_Intel.zip"
    sha256 "875a3dc0b4b0c941ba1006df83ffc3f43119fd6a1e2ed5a4d09034bb6f8cfe24"
  else
    url "https://github.com/abrignoni/iLEAPP/releases/download/v2.1.3/ileapp-v2.1.3-Apple_Silicon.zip"
    sha256 "f37fa2303c860282bcf6e7a6a84a87228e9710e1555f47a9d48120a0d81691c4"
  end

  def install
    bin.install "ileapp"
    chmod 0755, bin/"ileapp"
  end

  test do
    system "#{bin}/ileapp", "--version"
  end
end
