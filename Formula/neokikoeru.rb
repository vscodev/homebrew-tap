class Neokikoeru < Formula
  desc "Self-hosted streaming media server for DLsite voice works"
  homepage "https://github.com/vscodev/neokikoeru"
  version "2.6.0"

  if OS.mac?
    if Hardware::CPU.arm? || Hardware::CPU.in_rosetta2?
      url "https://github.com/vscodev/neokikoeru/releases/download/v2.6.0/neokikoeru-macos-arm64.tar.gz"
      sha256 "34006e285e297430ec54bf55d8b1a9d4c1d549850d1eae050ad5f719220e8c84"
    else
      url "https://github.com/vscodev/neokikoeru/releases/download/v2.6.0/neokikoeru-macos-amd64.tar.gz"
      sha256 "d7791b737a9b897aed2120835297c7c77e20b1b0cd65ccc440207f0d7fba7abf"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/vscodev/neokikoeru/releases/download/v2.6.0/neokikoeru-linux-arm64.tar.gz"
      sha256 "db7972f0670e310e71da9d17909863b56b6b1d5080f471aad5043c147b15053d"
    else
      url "https://github.com/vscodev/neokikoeru/releases/download/v2.6.0/neokikoeru-linux-amd64.tar.gz"
      sha256 "b9ea6d82f709e011608c7f9f4f1576d8e78d0cc2a8c2673b39fa15b432f03434"
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