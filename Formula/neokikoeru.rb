class Neokikoeru < Formula
  desc "Cloud storage-based web media player for DLsite voice works"
  homepage "https://github.com/vscodev/neokikoeru"
  version "1.1.0"

  if OS.mac?
    if Hardware::CPU.arm? || Hardware::CPU.in_rosetta2?
      url "https://github.com/vscodev/neokikoeru/releases/download/v1.1.0/neokikoeru-macos-arm64.tar.gz"
      sha256 "fc3830af22e99227fac94f2c3cc12f7a50ebd1c752f9d15a9f4243f2feb91465"
    else
      url "https://github.com/vscodev/neokikoeru/releases/download/v1.1.0/neokikoeru-macos-amd64.tar.gz"
      sha256 "caafc42a896ddcdd70cddebfb221878b1759fce0e61cb6fa21fbe41f165c43b7"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/vscodev/neokikoeru/releases/download/v1.1.0/neokikoeru-linux-arm64.tar.gz"
      sha256 "b4171432e82a9a8cf71e16717cde269e98725e63157b2b2e80080e2d1964a914"
    else
      url "https://github.com/vscodev/neokikoeru/releases/download/v1.1.0/neokikoeru-linux-amd64.tar.gz"
      sha256 "15709339cdc712bd2678fa788cbe95299d89e79a94dcf84424a9881fac8c503e"
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