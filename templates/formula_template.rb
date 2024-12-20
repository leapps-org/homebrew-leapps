class {{ClassName}} < Formula
  desc "{{desc}}"
  homepage "{{homepage}}"

  if Hardware::CPU.intel?
    url "{{intel_url}}"
    sha256 "{{intel_sha}}"
  else
    url "{{arm_url}}"
    sha256 "{{arm_sha}}"
  end

  def install
    bin.install "{{binary_name}}"
    chmod 0755, bin/"{{binary_name}}"
  end

  test do
    system "#{bin}/{{binary_name}}", "--version"
  end
end
