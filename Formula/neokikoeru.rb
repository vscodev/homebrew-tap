class Neokikoeru < Formula
  desc "High-performance streaming media server for DLsite voice works"
  homepage "https://github.com/vscodev/neokikoeru"
  version "3.33.0"

  if OS.mac?
    if Hardware::CPU.arm? || Hardware::CPU.in_rosetta2?
      url "https://github.com/vscodev/neokikoeru/releases/download/v3.33.0/neokikoeru-macos-arm64.tar.gz"
      sha256 "079369bf139dc0a568eb011b6f12b3a11af3965c16eccabffbcedfcf91de00ac"
    else
      url "https://github.com/vscodev/neokikoeru/releases/download/v3.33.0/neokikoeru-macos-amd64.tar.gz"
      sha256 "26640b21cea18bcc445ad36e0f594c1d46a8b1c61546e8e5b9987a296f48459e"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/vscodev/neokikoeru/releases/download/v3.33.0/neokikoeru-linux-arm64.tar.gz"
      sha256 "5d3923af91ba98e8d1a9f3ee42d9f76033765cde6c603db66dd2fd861185eae7"
    else
      url "https://github.com/vscodev/neokikoeru/releases/download/v3.33.0/neokikoeru-linux-amd64.tar.gz"
      sha256 "aec8f81fad7ca74351085792dee217ffe283e51254ce353627a36acbbe9da28f"
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