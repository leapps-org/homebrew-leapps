class Rleapp < Formula
  desc "Digital forensics tool for parsing service provider warrant or data return files"
  homepage "https://github.com/abrignoni/RLEAPP"

  if Hardware::CPU.intel?
    url "https://github.com/abrignoni/RLEAPP/releases/download/v2.2.0/rleapp-v2.2.0-macOS_Mac_Intel.zip"
    sha256 "b568e8dd449857272e78965ebfa25c4ad0c44068c941d02f249f4ef06034cc88"
  else
    url "https://github.com/abrignoni/RLEAPP/releases/download/v2.2.0/rleapp-v2.2.0-macOS_Apple_Silicon.zip"
    sha256 "e9f40b5877b3f155d4ecab9471769b3726bdd47a3ae68e5d4065f765278a2a28"
  end

  def install
    bin.install "rleapp"
    chmod 0755, bin/"rleapp"
  end

  test do
    system "#{bin}/rleapp", "--version"
  end
end
