cask "aleapp-gui" do
  version "v3.4.0"

  if Hardware::CPU.intel?
    url "https://github.com/abrignoni/aLEAPP/releases/download/v3.4.0/aleappGUI-v3.4.0-Mac_Intel.dmg"
    sha256 "204730dd51d18340f98e1f2e51e4f1dc120d5adace3aaef3afd92920ffdd7f65"
  else
    url "https://github.com/abrignoni/aLEAPP/releases/download/v3.4.0/aleappGUI-v3.4.0-Apple_Silicon.dmg"
    sha256 "b890766da18f3c2cd12f27fb70477c1c53885c3e17e15ffb1e5fb3117b323d41"
  end

  name "aLEAPP GUI"
  desc "Digital forensics tool for analyzing Android artifacts with graphical interface"
  homepage "https://github.com/abrignoni/aLEAPP"

  app "aleappGUI.app"
end
