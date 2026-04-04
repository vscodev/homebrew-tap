class Neokikoeru < Formula
  desc "Self-hosted streaming media server for DLsite voice works"
  homepage "https://github.com/vscodev/neokikoeru"
  version "1.9.5"

  if OS.mac?
    if Hardware::CPU.arm? || Hardware::CPU.in_rosetta2?
      url "https://github.com/vscodev/neokikoeru/releases/download/v1.9.5/neokikoeru-macos-arm64.tar.gz"
      sha256 "63b9b78105819f0fdac4477d110d599da2a18c60acb219d6414fb9f4a0558604"
    else
      url "https://github.com/vscodev/neokikoeru/releases/download/v1.9.5/neokikoeru-macos-amd64.tar.gz"
      sha256 "cc0ad546ced4cb73e6650b647692399a31b90edeecec1307513e6ab8e285432f"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/vscodev/neokikoeru/releases/download/v1.9.5/neokikoeru-linux-arm64.tar.gz"
      sha256 "c2b27c2a3dea65cfe4d747a540ec324526573e9b55a75ec362d9e758dd0adcf3"
    else
      url "https://github.com/vscodev/neokikoeru/releases/download/v1.9.5/neokikoeru-linux-amd64.tar.gz"
      sha256 "ca2b8a4e7d5bee0e3fa181ccda879dc776f6cf4585d78739fae3a60190e20a71"
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