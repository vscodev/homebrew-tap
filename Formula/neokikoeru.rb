class Neokikoeru < Formula
  desc "High-performance streaming media server for DLsite voice works"
  homepage "https://github.com/vscodev/neokikoeru"
  version "3.29.0"

  if OS.mac?
    if Hardware::CPU.arm? || Hardware::CPU.in_rosetta2?
      url "https://github.com/vscodev/neokikoeru/releases/download/v3.29.0/neokikoeru-macos-arm64.tar.gz"
      sha256 "b2f05685d2fcab69110b66c1320e550be5f64e5f5ccb238b27eddc093f64ac82"
    else
      url "https://github.com/vscodev/neokikoeru/releases/download/v3.29.0/neokikoeru-macos-amd64.tar.gz"
      sha256 "a7df2dcab65bc02a99cb3e7ce7b4b44184cba39d28418ef4c861b6149fcef861"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/vscodev/neokikoeru/releases/download/v3.29.0/neokikoeru-linux-arm64.tar.gz"
      sha256 "a3f0f475f7fcfa020333f458797bef6655a37e79a68b65c96676bcd692fc68c7"
    else
      url "https://github.com/vscodev/neokikoeru/releases/download/v3.29.0/neokikoeru-linux-amd64.tar.gz"
      sha256 "7b4439f74bb46928aa7a53d44876b0f8f0846bd7efd87826156fbac40989ed32"
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