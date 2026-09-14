cask "rleapp-gui" do
  version "v2026.4.0"

  if Hardware::CPU.intel?
    url "https://github.com/abrignoni/RLEAPP/releases/download/v2026.4.0/rleappGUI-v2026.4.0-macOS_Mac_Intel.dmg"
    sha256 "d8c5ebbad9de5d427119d46b5b1a819cab927378f9602fe0ebc5143cacdfa18a"
  else
    url "https://github.com/abrignoni/RLEAPP/releases/download/v2026.4.0/rleappGUI-v2026.4.0-macOS_Apple_Silicon.dmg"
    sha256 "ea96f7f30ceb1b0747c7cded878d36e5a0a03602d32219643ff5865bc0911efd"
  end

  name "RLEAPP GUI"
  desc "Digital forensics tool for parsing service provider warrant or data return files with graphical interface"
  homepage "https://github.com/abrignoni/RLEAPP"

  app "rleappGUI.app"
end
