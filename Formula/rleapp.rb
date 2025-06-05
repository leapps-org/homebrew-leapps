class Rleapp < Formula
  desc "Digital forensics tool for parsing service provider warrant or data return files"
  homepage "https://github.com/abrignoni/RLEAPP"

  if Hardware::CPU.intel?
    url "https://github.com/abrignoni/RLEAPP/releases/download/v1.1.2/rleapp-1.1.2-Mac_Intel.zip"
    sha256 "1a54ee3c2df7a8230ab8663bad15731208093868f6c578d73c661ac4a9e6dcef"
  else
    url "https://github.com/abrignoni/RLEAPP/releases/download/v1.1.2/rleapp-1.1.2-Apple_Silicon.zip"
    sha256 "8bccbe3d20ad6be4a31a8caa642b20b3e01e09ea872e3681c16cdc603897a747"
  end

  def install
    bin.install "rleapp"
    chmod 0755, bin/"rleapp"
  end

  test do
    system "#{bin}/rleapp", "--version"
  end
end
