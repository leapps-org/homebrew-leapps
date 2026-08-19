class Ileapp < Formula
  desc "Digital forensics tool for parsing iOS backup files, images, and artifacts"
  homepage "https://github.com/abrignoni/iLEAPP"

  if Hardware::CPU.intel?
    url "https://github.com/abrignoni/iLEAPP/releases/download/v2026.3.1/ileapp-v2026.3.1-macOS_Mac_Intel.zip"
    sha256 "5e29c64e2cee37dbc2cbfbe21590c476be6301af368d686db973c7f4f7fcb10f"
  else
    url "https://github.com/abrignoni/iLEAPP/releases/download/v2026.3.1/ileapp-v2026.3.1-macOS_Apple_Silicon.zip"
    sha256 "90bbbe0c145a4a970e693dd0c41532674091f329818cf70ccd00666b2a5c7e59"
  end

  def install
    bin.install "ileapp"
    chmod 0755, bin/"ileapp"
  end

  test do
    system "#{bin}/ileapp", "--version"
  end
end
