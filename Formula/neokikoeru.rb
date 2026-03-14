class Neokikoeru < Formula
  desc "Cloud storage-based web media player for DLsite voice works"
  homepage "https://github.com/vscodev/neokikoeru"
  version "1.5.2"

  if OS.mac?
    if Hardware::CPU.arm? || Hardware::CPU.in_rosetta2?
      url "https://github.com/vscodev/neokikoeru/releases/download/v1.5.2/neokikoeru-macos-arm64.tar.gz"
      sha256 "30394afd3e8582ee6b3e2124022895d0643786a1fedc11fc40842aaca61ec856"
    else
      url "https://github.com/vscodev/neokikoeru/releases/download/v1.5.2/neokikoeru-macos-amd64.tar.gz"
      sha256 "57bbb797e857098a7f179531cc96f474390f72ca44bc734320166497c621e34c"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/vscodev/neokikoeru/releases/download/v1.5.2/neokikoeru-linux-arm64.tar.gz"
      sha256 "991316bccc7e4689795956278c06adcd04dfc45f1910a3303ca4f8663a4a3bf7"
    else
      url "https://github.com/vscodev/neokikoeru/releases/download/v1.5.2/neokikoeru-linux-amd64.tar.gz"
      sha256 "776178d4f98538e6aeebbfc163f16033009b798d93ef45bb3dcca547c8771e0c"
    end
  else
    odie "Unsupported platform. Please submit a bug report here: https://github.com/vscodev/neokikoeru/issues\n#{OS.report}"
  end

  def install
    bin.install "neokikoeru"
    generate_completions_from_executable(bin/"neokikoeru", "completion")
  end

  service do
    run [bin/"neokikoeru", "start"]
    keep_alive crashed: true
    log_path var/"log/neokikoeru.log"
    error_log_path var/"log/neokikoeru.log"
  end

  test do
    assert_match "neokikoeru version #{version}", shell_output("#{bin}/neokikoeru -v")
  end
end