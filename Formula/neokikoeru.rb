class Neokikoeru < Formula
  desc "Cloud storage-based web media player for DLsite voice works"
  homepage "https://github.com/vscodev/neokikoeru"
  version "1.1.2"

  if OS.mac?
    if Hardware::CPU.arm? || Hardware::CPU.in_rosetta2?
      url "https://github.com/vscodev/neokikoeru/releases/download/v1.1.2/neokikoeru-macos-arm64.tar.gz"
      sha256 "6fe311c2537993ddaacab2c7555000743f62b9d167f5b93fdaa4e0e0144b8680"
    else
      url "https://github.com/vscodev/neokikoeru/releases/download/v1.1.2/neokikoeru-macos-amd64.tar.gz"
      sha256 "7b2bf846fe5548a6be397905ecea6b14c6f0ce94eaea766243e0218582a47d66"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/vscodev/neokikoeru/releases/download/v1.1.2/neokikoeru-linux-arm64.tar.gz"
      sha256 "5f40aeb10ad8ffc64da0243dec4e1c060724afc6972d681b0f41bd8de45ecc44"
    else
      url "https://github.com/vscodev/neokikoeru/releases/download/v1.1.2/neokikoeru-linux-amd64.tar.gz"
      sha256 "3273b67634ca7677f8bb453adeace6e36999cd2a97e89a300c184e690f7614d3"
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