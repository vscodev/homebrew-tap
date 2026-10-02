class Neokikoeru < Formula
  desc "High-performance streaming media server for DLsite voice works"
  homepage "https://github.com/vscodev/neokikoeru"
  version "3.23.7"

  if OS.mac?
    if Hardware::CPU.arm? || Hardware::CPU.in_rosetta2?
      url "https://github.com/vscodev/neokikoeru/releases/download/v3.23.7/neokikoeru-macos-arm64.tar.gz"
      sha256 "9ee82ccb14a6139baa4c01d9a0b58f213e78aa47f276f511f9e910d315613353"
    else
      url "https://github.com/vscodev/neokikoeru/releases/download/v3.23.7/neokikoeru-macos-amd64.tar.gz"
      sha256 "38d17703c9d819f961a47d6bca5fcf2089eb6a3179e7daa99552157345ebf3ab"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/vscodev/neokikoeru/releases/download/v3.23.7/neokikoeru-linux-arm64.tar.gz"
      sha256 "f81d8f2aa7a8e1a71b522ea43faf29219a0c96a24ff015d04c0e323263f4d7d4"
    else
      url "https://github.com/vscodev/neokikoeru/releases/download/v3.23.7/neokikoeru-linux-amd64.tar.gz"
      sha256 "7b81b8847e97dda5d7b717a83cd89297335c9a49c432160333bba3a99fe1c3a5"
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