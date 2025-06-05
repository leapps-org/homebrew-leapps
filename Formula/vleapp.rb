class Vleapp < Formula
  desc "Digital forensics tool for parsing vehicle infotainment system backup files, images, and artifacts"
  homepage "https://github.com/abrignoni/VLEAPP"

  if Hardware::CPU.intel?
    url "https://github.com/abrignoni/VLEAPP/releases/download/v2.1.2/vleapp-2.1.2-Mac_Intel.zip"
    sha256 "12fcc583ca0220bcaa9eb8f5a73a939742b78b3d4606fcf038c0beda61ffd4e5"
  else
    url "https://github.com/abrignoni/VLEAPP/releases/download/v2.1.2/vleapp-2.1.2-Apple_Silicon.zip"
    sha256 "91eaf8543c9eff4ff016e4cf58af1e9f7c4065ea8913f8e271b179285ebab3d4"
  end

  def install
    bin.install "vleapp"
    chmod 0755, bin/"vleapp"
  end

  test do
    system "#{bin}/vleapp", "--version"
  end
end
