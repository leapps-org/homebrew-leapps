class Vleapp < Formula
  desc "Digital forensics tool for parsing vehicle infotainment system backup files, images, and artifacts"
  homepage "https://github.com/abrignoni/VLEAPP"

  if Hardware::CPU.intel?
    url "https://github.com/abrignoni/VLEAPP/releases/download/v2.2.0/vleapp-v2.2.0-macOS_Mac_Intel.zip"
    sha256 "6d8e1421f1342c8536218cb21d743a60b78ef02271b5a9dd62eb14c9ecd4733d"
  else
    url "https://github.com/abrignoni/VLEAPP/releases/download/v2.2.0/vleapp-v2.2.0-macOS_Apple_Silicon.zip"
    sha256 "d89a192ab7771acf76459e4297460ceef242d8c177b95b5ebc361d42e5397894"
  end

  def install
    bin.install "vleapp"
    chmod 0755, bin/"vleapp"
  end

  test do
    system "#{bin}/vleapp", "--version"
  end
end
