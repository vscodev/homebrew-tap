class Neokikoeru < Formula
  desc "High-performance streaming media server for DLsite voice works"
  homepage "https://github.com/vscodev/neokikoeru"
  version "3.30.1"

  if OS.mac?
    if Hardware::CPU.arm? || Hardware::CPU.in_rosetta2?
      url "https://github.com/vscodev/neokikoeru/releases/download/v3.30.1/neokikoeru-macos-arm64.tar.gz"
      sha256 "63ebd18b911d35cdcd936af8da94d22a302f1d15f910a68c5fefd4a1273e7e84"
    else
      url "https://github.com/vscodev/neokikoeru/releases/download/v3.30.1/neokikoeru-macos-amd64.tar.gz"
      sha256 "ef8b8180e5467131e0d89045a3507797cb6f2c02130afc3b06bfb791079ee2aa"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/vscodev/neokikoeru/releases/download/v3.30.1/neokikoeru-linux-arm64.tar.gz"
      sha256 "a1aa55ee62a04b1e5994dfcd933ba84dd4ae7e324df7da609a6be2ed70764d9b"
    else
      url "https://github.com/vscodev/neokikoeru/releases/download/v3.30.1/neokikoeru-linux-amd64.tar.gz"
      sha256 "cb5c3ad0674e24c5e6bd8fcf5a850603bfb7ba697969f76e1d3b39ff59f50f7e"
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