class Neokikoeru < Formula
  desc "Self-hosted streaming media server for DLsite voice works"
  homepage "https://github.com/vscodev/neokikoeru"
  version "3.22.6"

  if OS.mac?
    if Hardware::CPU.arm? || Hardware::CPU.in_rosetta2?
      url "https://github.com/vscodev/neokikoeru/releases/download/v3.22.6/neokikoeru-macos-arm64.tar.gz"
      sha256 "6ca09c03c2b38ea2797bdabdd1911706212cd48375fadfe147a5666a3c4dc86e"
    else
      url "https://github.com/vscodev/neokikoeru/releases/download/v3.22.6/neokikoeru-macos-amd64.tar.gz"
      sha256 "8d00ad63850504a395c7e602dab23599435d7cca71c59bace487770d56ecfe1a"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/vscodev/neokikoeru/releases/download/v3.22.6/neokikoeru-linux-arm64.tar.gz"
      sha256 "266651fc2ed68ee6b3cd9860e835af5e1240dcd73d277babcf347e33406e8a12"
    else
      url "https://github.com/vscodev/neokikoeru/releases/download/v3.22.6/neokikoeru-linux-amd64.tar.gz"
      sha256 "7782d12875b45a488d0530adb0b1d2ead1ad9ac7f56522a73382280f46ca1592"
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