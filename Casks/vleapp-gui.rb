cask "vleapp-gui" do
  version "v2026.2.0"

  if Hardware::CPU.intel?
    url "https://github.com/abrignoni/VLEAPP/releases/download/v2026.2.0/vleappGUI-v2026.2.0-macOS_Mac_Intel.dmg"
    sha256 "df050539087b549a3c31b1cbdf61d229cd11eeea6d20366e7df1234b244a6ffd"
  else
    url "https://github.com/abrignoni/VLEAPP/releases/download/v2026.2.0/vleappGUI-v2026.2.0-macOS_Apple_Silicon.dmg"
    sha256 "2c921cbded5867ea1947a41e4b79ef16b6117e034bc97413ac31cfecd6bfbff0"
  end

  name "VLEAPP GUI"
  desc "Digital forensics tool for analyzing vehicle infotainment system artifacts with graphical interface"
  homepage "https://github.com/abrignoni/VLEAPP"

  app "vleappGUI.app"
end
