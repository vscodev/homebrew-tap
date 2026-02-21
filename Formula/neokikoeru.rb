class Neokikoeru < Formula
  desc "Cloud storage-based web media player for DLsite voice works"
  homepage "https://github.com/vscodev/neokikoeru"
  version "1.2.0"

  if OS.mac?
    if Hardware::CPU.arm? || Hardware::CPU.in_rosetta2?
      url "https://github.com/vscodev/neokikoeru/releases/download/v1.2.0/neokikoeru-macos-arm64.tar.gz"
      sha256 "c6a0d848630442be5a5eb4513c8d69ebfcd88b17f69057f7a4a2165358a365f2"
    else
      url "https://github.com/vscodev/neokikoeru/releases/download/v1.2.0/neokikoeru-macos-amd64.tar.gz"
      sha256 "8b56ccb60bca5ace3ba1215553257d23ef6e77e011e6e276d50f923b5ddbf980"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/vscodev/neokikoeru/releases/download/v1.2.0/neokikoeru-linux-arm64.tar.gz"
      sha256 "287d0d7d9f5c5ffea66653e4945122c7512a0ddf20339a09e6c1b1f2d75e6809"
    else
      url "https://github.com/vscodev/neokikoeru/releases/download/v1.2.0/neokikoeru-linux-amd64.tar.gz"
      sha256 "d7acd6d7c1ef951dc87232843be33ef77937c9d5d4887bfa2103431db42abcaf"
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