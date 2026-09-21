class Ileapp < Formula
  desc "Digital forensics tool for parsing iOS backup files, images, and artifacts"
  homepage "https://github.com/abrignoni/iLEAPP"

  if Hardware::CPU.intel?
    url "https://github.com/abrignoni/iLEAPP/releases/download/v2026.4.2/ileapp-v2026.4.2-macOS_Mac_Intel.zip"
    sha256 "32889a7b849d54a973b90e9b1fb25e6e9e43a67416ce76486029e71a4115c94a"
  else
    url "https://github.com/abrignoni/iLEAPP/releases/download/v2026.4.2/ileapp-v2026.4.2-macOS_Apple_Silicon.zip"
    sha256 "d99f2d05dbde20ee997de477c38443d4f019d60326a8c6b9456058c6cf590386"
  end

  def install
    bin.install "ileapp"
    chmod 0755, bin/"ileapp"
  end

  test do
    system "#{bin}/ileapp", "--version"
  end
end
