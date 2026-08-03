cask "ileapp-gui" do
  version "v2026.2.1"

  if Hardware::CPU.intel?
    url "https://github.com/abrignoni/iLEAPP/releases/download/v2026.2.1/ileappGUI-v2026.2.1-macOS_Mac_Intel.dmg"
    sha256 "f727371e0bd73fe188f8fe2398dc0da0522a6a156b56f27f132a9a159e9e807a"
  else
    url "https://github.com/abrignoni/iLEAPP/releases/download/v2026.2.1/ileappGUI-v2026.2.1-macOS_Apple_Silicon.dmg"
    sha256 "faa598b149ef091c07ae6d1b63875cc72eae3002bfb0b30c1b7417524cdbae00"
  end

  name "iLEAPP GUI"
  desc "Digital forensics tool for analyzing iOS artifacts with graphical interface"
  homepage "https://github.com/abrignoni/iLEAPP"

  app "ileappGUI.app"
end
