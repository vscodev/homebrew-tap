class Neokikoeru < Formula
  desc "Self-hosted streaming media server for DLsite voice works"
  homepage "https://github.com/vscodev/neokikoeru"
  version "3.22.4"

  if OS.mac?
    if Hardware::CPU.arm? || Hardware::CPU.in_rosetta2?
      url "https://github.com/vscodev/neokikoeru/releases/download/v3.22.4/neokikoeru-macos-arm64.tar.gz"
      sha256 "925fde8cd532c5a5e76f5f7fe76b62945db3697ad86c8566d9fff2e8e1b3a8cd"
    else
      url "https://github.com/vscodev/neokikoeru/releases/download/v3.22.4/neokikoeru-macos-amd64.tar.gz"
      sha256 "50c38073772e38cd51619dfd520aa9a434731d4a5e9ffdc2fb8dcf48ce7820b4"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/vscodev/neokikoeru/releases/download/v3.22.4/neokikoeru-linux-arm64.tar.gz"
      sha256 "ac29b725fe4a7b314bd2b626b8a23150414b971aa6e5485506282d2651f270a2"
    else
      url "https://github.com/vscodev/neokikoeru/releases/download/v3.22.4/neokikoeru-linux-amd64.tar.gz"
      sha256 "0698da0ad41024c08f9114ac1e5ab232ea7a05f5d5c4dfbc8edaddcf36f76d30"
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