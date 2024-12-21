cask "ileapp-gui" do
  version "v2.0.2"

  if Hardware::CPU.intel?
    url "https://github.com/abrignoni/iLEAPP/releases/download/v2.0.2/ileappGUI-v2.0.2-Mac_Intel.dmg"
    sha256 "393f4b494dcb904542525ee909d12c08fe85f70529becee514164b33d2ad4312"
  else
    url "https://github.com/abrignoni/iLEAPP/releases/download/v2.0.2/ileappGUI-v2.0.2-Apple_Silicon.dmg"
    sha256 "5d28353fd081bf03888e7952234c1ee557a79bc314e7549ff25bae20e3d94e6f"
  end

  name "iLEAPP GUI"
  desc "Digital forensics tool for analyzing iOS artifacts with graphical interface"
  homepage "https://github.com/abrignoni/iLEAPP"

  app "ileappGUI.app"
end
