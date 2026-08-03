class Aleapp < Formula
  desc "Digital forensics tool for parsing Android backup files, images, and artifacts"
  homepage "https://github.com/abrignoni/aLEAPP"

  if Hardware::CPU.intel?
    url "https://github.com/abrignoni/ALEAPP/releases/download/v2026.2.0/aleapp-v2026.2.0-macOS_Mac_Intel.zip"
    sha256 "cb8591bd1543f37dac418576b59641d74326f199cf42caf474cda1332bdb7882"
  else
    url "https://github.com/abrignoni/ALEAPP/releases/download/v2026.2.0/aleapp-v2026.2.0-macOS_Apple_Silicon.zip"
    sha256 "0a8ce1133e678575a9b0fbd0e892a809519b245cbfaac89fdaa01a4ef6c54be6"
  end

  def install
    bin.install "aleapp"
    chmod 0755, bin/"aleapp"
  end

  test do
    system "#{bin}/aleapp", "--version"
  end
end
