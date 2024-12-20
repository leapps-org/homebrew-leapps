cask "{{cask_name}}" do
  version "{{version}}"

  if Hardware::CPU.intel?
    url "{{gui_intel_url}}"
    sha256 "{{gui_intel_sha}}"
  else
    url "{{gui_arm_url}}"
    sha256 "{{gui_arm_sha}}"
  end

  name "{{app_name}}"
  desc "{{desc_gui}}"
  homepage "{{homepage}}"

  app "{{app_bundle}}.app"
end
