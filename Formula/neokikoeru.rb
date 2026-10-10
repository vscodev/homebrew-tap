class Neokikoeru < Formula
  desc "High-performance streaming media server for DLsite voice works"
  homepage "https://github.com/vscodev/neokikoeru"
  version "3.26.1"

  if OS.mac?
    if Hardware::CPU.arm? || Hardware::CPU.in_rosetta2?
      url "https://github.com/vscodev/neokikoeru/releases/download/v3.26.1/neokikoeru-macos-arm64.tar.gz"
      sha256 "7632001a0e2c153e1258f45edc3aba7e71258dd9b0594448ca0d5a9f7a6e7611"
    else
      url "https://github.com/vscodev/neokikoeru/releases/download/v3.26.1/neokikoeru-macos-amd64.tar.gz"
      sha256 "9d4c338bc112938edb9486024a0f9bcc4af0bfb09487c258bf06935b6c01861c"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/vscodev/neokikoeru/releases/download/v3.26.1/neokikoeru-linux-arm64.tar.gz"
      sha256 "39ffdc580ab2349867d54ca798d8290a5e9c0fe67d1c51e9319e38eb35070ba8"
    else
      url "https://github.com/vscodev/neokikoeru/releases/download/v3.26.1/neokikoeru-linux-amd64.tar.gz"
      sha256 "d32ca70bf18025fd55b5e1a5313adb18e04ad4dbdc92ab57ed7d87e112e3a132"
    end
  else
    odie "Unsupported platform. Please submit a bug report here: https://github.com/vscodev/neokikoeru/issues\n#{OS.report}"
  end

  def install
    bin.install "neokikoeru"
    generate_completions_from_executable(bin/"neokikoeru", "completion")
  end

  service do
    run [bin/"neokikoeru", "serve"]
    keep_alive crashed: true
    log_path var/"log/neokikoeru.log"
    error_log_path var/"log/neokikoeru.log"
  end

  test do
    assert_match "neokikoeru version #{version}", shell_output("#{bin}/neokikoeru -v")
  end
end