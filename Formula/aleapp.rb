class Aleapp < Formula
  desc "Digital forensics tool for parsing Android backup files, images, and artifacts"
  homepage "https://github.com/abrignoni/aLEAPP"

  if Hardware::CPU.intel?
    url "https://github.com/abrignoni/aLEAPP/releases/download/v3.4.1/aleapp-v3.4.1-Mac_Intel.zip"
    sha256 "c1b52dd4375dd849c5f5ae3f99a0b61af95c5a9f43a3b772d712347593106c8e"
  else
    url "https://github.com/abrignoni/aLEAPP/releases/download/v3.4.1/aleapp-v3.4.1-Apple_Silicon.zip"
    sha256 "7f8d30b66509dfc59db14a30fa765a797ca94f21ee3ca44baf92b7aa94c2d315"
  end

  def install
    bin.install "aleapp"
    chmod 0755, bin/"aleapp"
  end

  test do
    system "#{bin}/aleapp", "--version"
  end
end
