class Vleapp < Formula
  desc "Digital forensics tool for parsing vehicle infotainment system backup files, images, and artifacts"
  homepage "https://github.com/abrignoni/VLEAPP"

  if Hardware::CPU.intel?
    url "https://github.com/abrignoni/VLEAPP/releases/download/v2026.4.0/vleapp-v2026.4.0-macOS_Mac_Intel.zip"
    sha256 "b770323b23ae0ce08c0381a295038f86309a0377165adcb6ca5375dd454d98d4"
  else
    url "https://github.com/abrignoni/VLEAPP/releases/download/v2026.4.0/vleapp-v2026.4.0-macOS_Apple_Silicon.zip"
    sha256 "9281b7b6aec4fc589dde27f3b27f1dcf435dc919abd7ac3cf11b1e2e2c348bf0"
  end

  def install
    bin.install "vleapp"
    chmod 0755, bin/"vleapp"
  end

  test do
    system "#{bin}/vleapp", "--version"
  end
end
