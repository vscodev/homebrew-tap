class Neokikoeru < Formula
  desc "Cloud storage-based web media player for DLsite voice works"
  homepage "https://github.com/vscodev/neokikoeru"
  version "1.0.1"

  if OS.mac?
    if Hardware::CPU.arm? || Hardware::CPU.in_rosetta2?
      url "https://github.com/vscodev/neokikoeru/releases/download/v1.0.1/neokikoeru-macos-arm64.tar.gz"
      sha256 "a0e1a5fadea7bc50f0121b2cf5a85324fb44b346e55cd4e7a2422e947a73cc9c"
    else
      url "https://github.com/vscodev/neokikoeru/releases/download/v1.0.1/neokikoeru-macos-amd64.tar.gz"
      sha256 "d968412e824fd995593d8fbd0d76fe90e8bbc07dfb90ecae4bced789c0ddbb07"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/vscodev/neokikoeru/releases/download/v1.0.1/neokikoeru-linux-arm64.tar.gz"
      sha256 "ac1fbee6795237908379a419630a61994c31ccfdb7f56cd3e703a8462e987a71"
    else
      url "https://github.com/vscodev/neokikoeru/releases/download/v1.0.1/neokikoeru-linux-amd64.tar.gz"
      sha256 "e11aa7776f0f7c366fb556b701bcaf1c3dcfb5b89c24bc6dd43b3cb5a1be550f"
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