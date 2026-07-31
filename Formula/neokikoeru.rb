class Neokikoeru < Formula
  desc "Self-hosted streaming media server for DLsite voice works"
  homepage "https://github.com/vscodev/neokikoeru"
  version "3.21.0"

  if OS.mac?
    if Hardware::CPU.arm? || Hardware::CPU.in_rosetta2?
      url "https://github.com/vscodev/neokikoeru/releases/download/v3.21.0/neokikoeru-macos-arm64.tar.gz"
      sha256 "d58400036f67f851791cf145447bc38d5b923908c63363ed21ed2baca86516b3"
    else
      url "https://github.com/vscodev/neokikoeru/releases/download/v3.21.0/neokikoeru-macos-amd64.tar.gz"
      sha256 "06eb0e76e6d9c7b25ff2a69c114070e5210e3c5c465525c96d99b96919fdc483"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/vscodev/neokikoeru/releases/download/v3.21.0/neokikoeru-linux-arm64.tar.gz"
      sha256 "20db61d5ba2691916e86f21b3f49a4294f99ffee837a2ac53d9e540259a5d399"
    else
      url "https://github.com/vscodev/neokikoeru/releases/download/v3.21.0/neokikoeru-linux-amd64.tar.gz"
      sha256 "9446e5121e3aecc7670f4673da5ac9297414a295f5d00d4f80570ef0a987153c"
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