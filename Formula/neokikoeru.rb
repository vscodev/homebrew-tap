class Neokikoeru < Formula
  desc "Self-hosted streaming media server for DLsite voice works"
  homepage "https://github.com/vscodev/neokikoeru"
  version "3.19.1"

  if OS.mac?
    if Hardware::CPU.arm? || Hardware::CPU.in_rosetta2?
      url "https://github.com/vscodev/neokikoeru/releases/download/v3.19.1/neokikoeru-macos-arm64.tar.gz"
      sha256 "a61f38bbd21f59545c428bd99289ada84ac4770c9b9dfbdf41f8c719b7ef3387"
    else
      url "https://github.com/vscodev/neokikoeru/releases/download/v3.19.1/neokikoeru-macos-amd64.tar.gz"
      sha256 "8989e7ddaefe3da310d94ade2a66048d91817f5a8bff9654ed10384bd2773b73"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/vscodev/neokikoeru/releases/download/v3.19.1/neokikoeru-linux-arm64.tar.gz"
      sha256 "53bc4e547f8f1ef70a582a38fde60fb663d77279431c779dd8e584dd27b0a3de"
    else
      url "https://github.com/vscodev/neokikoeru/releases/download/v3.19.1/neokikoeru-linux-amd64.tar.gz"
      sha256 "d41a79dcc230a17e2505b6233d4a175d5423f58448a1f1e515e1d590777fae34"
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