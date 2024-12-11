# Cask for GUI (ileapp-gui.rb)
cask "ileapp-gui" do
    version "2.0.1"
    
    if Hardware::CPU.intel?
      url "https://github.com/abrignoni/iLEAPP/releases/download/v#{version}/ileappGUI-#{version}-Mac_Intel.dmg"
      sha256 "65ec26df2f83bbe33f2da946651d84abef47f65d0cb64b21ea0590bb0944e77e"
    else
      url "https://github.com/abrignoni/iLEAPP/releases/download/v#{version}/ileappGUI-#{version}-Apple_Silicon.dmg"
      sha256 "f308bccafc82fca5f81f8c137a1f05f23fac76634d6b93829582362f7a68465a"
    end
  
    name "iLEAPP GUI"
    desc "Digital forensics tool for analyzing iOS artifacts with graphical interface"
    homepage "https://github.com/abrignoni/iLEAPP"
  
    app "ileappGUI.app"
  end
