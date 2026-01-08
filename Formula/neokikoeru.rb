class Neokikoeru < Formula
  desc "Cloud storage-based web media player for DLsite voice works"
  homepage "https://github.com/vscodev/neokikoeru"
  version "1.0.0"

  if OS.mac?
    if Hardware::CPU.arm? || Hardware::CPU.in_rosetta2?
      url "https://github.com/vscodev/neokikoeru/releases/download/v1.0.0/neokikoeru-macos-arm64.tar.gz"
      sha256 "e054f026f1a491f86534b7dd51744148bc59ddd80eddb1bc5252de0a36d9018d"
    else
      url "https://github.com/vscodev/neokikoeru/releases/download/v1.0.0/neokikoeru-macos-amd64.tar.gz"
      sha256 "4b5bdf994d85fed093e4889c8d5424f00cdd26a94d3b73d23357e489af8e225a"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/vscodev/neokikoeru/releases/download/v1.0.0/neokikoeru-linux-arm64.tar.gz"
      sha256 "60e8b284d9e89712678b3f7206a2943b60937990da6f3cd98568d71abe923aca"
    else
      url "https://github.com/vscodev/neokikoeru/releases/download/v1.0.0/neokikoeru-linux-amd64.tar.gz"
      sha256 "c5a40103f9d17f8889b7a7f3ce4ac3366fea18bb3b7939d8d1e86bf09590dc9a"
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