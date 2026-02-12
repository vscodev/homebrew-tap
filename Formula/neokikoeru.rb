class Neokikoeru < Formula
  desc "Cloud storage-based web media player for DLsite voice works"
  homepage "https://github.com/vscodev/neokikoeru"
  version "1.1.1"

  if OS.mac?
    if Hardware::CPU.arm? || Hardware::CPU.in_rosetta2?
      url "https://github.com/vscodev/neokikoeru/releases/download/v1.1.1/neokikoeru-macos-arm64.tar.gz"
      sha256 "31e8ec6a68b9df804df8a477521f30ad0910df59ba60847596fab2c5a54e2ebb"
    else
      url "https://github.com/vscodev/neokikoeru/releases/download/v1.1.1/neokikoeru-macos-amd64.tar.gz"
      sha256 "732deea12f2cc96011aeaff84fe2fde12c2ead08c26c006c3b1fb0cbdd91f772"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/vscodev/neokikoeru/releases/download/v1.1.1/neokikoeru-linux-arm64.tar.gz"
      sha256 "6141915cfbe27547d636144355f61ad5914a2078167b7e15c46016e57824e56d"
    else
      url "https://github.com/vscodev/neokikoeru/releases/download/v1.1.1/neokikoeru-linux-amd64.tar.gz"
      sha256 "1780c5ef941c8803a12e6a18745ac62edce3c5fb0b07469c6796d2cd1fd17724"
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