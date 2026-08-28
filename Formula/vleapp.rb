class Vleapp < Formula
  desc "Digital forensics tool for parsing vehicle infotainment system backup files, images, and artifacts"
  homepage "https://github.com/abrignoni/VLEAPP"

  if Hardware::CPU.intel?
    url "https://github.com/abrignoni/VLEAPP/releases/download/v2026.3.1/vleapp-v2026.3.1-macOS_Mac_Intel.zip"
    sha256 "79ff9934f4c843d7eeffdead63c2dfb95ef01b31f49178594a81e26f34f9ce16"
  else
    url "https://github.com/abrignoni/VLEAPP/releases/download/v2026.3.1/vleapp-v2026.3.1-macOS_Apple_Silicon.zip"
    sha256 "54c39c27188402b3b99501a5fd1a82ed457981e0a8cca9236bcb07bb112d3bd7"
  end

  def install
    bin.install "vleapp"
    chmod 0755, bin/"vleapp"
  end

  test do
    system "#{bin}/vleapp", "--version"
  end
end
