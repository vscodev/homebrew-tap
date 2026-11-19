class Drive2dav < Formula
  desc "A lightweight WebDAV server that supports multiple storages"
  homepage "https://github.com/vscodev/drive2dav"
  version "0.4.0"

  if OS.mac?
    if Hardware::CPU.arm? || Hardware::CPU.in_rosetta2?
      url "https://github.com/vscodev/drive2dav/releases/download/v0.4.0/drive2dav-macos-arm64.tar.gz"
      sha256 "51122f199f435fb42b941befe1736c4e9cbe8e41bdfa232266aa641da4e3b54a"
    else
      url "https://github.com/vscodev/drive2dav/releases/download/v0.4.0/drive2dav-macos-amd64.tar.gz"
      sha256 "c66a71647706e94c946ac19f0dfaf230c92bae1f07fd498437e93f1cd07f77a9"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/vscodev/drive2dav/releases/download/v0.4.0/drive2dav-linux-arm64.tar.gz"
      sha256 "1c74c21a1ec804cfb821f775555a7bfcc335f2c9b8fdf4d1ac9e7956c66415aa"
    else
      url "https://github.com/vscodev/drive2dav/releases/download/v0.4.0/drive2dav-linux-amd64.tar.gz"
      sha256 "e9b0bc90066995fcff14c3b5c4cc0a277bd9277028952e791640930802e47547"
    end
  else
    odie "Unsupported platform. Please submit a bug report here: https://github.com/vscodev/drive2dav/issues\n#{OS.report}"
  end

  def install
    bin.install "drive2dav"
    generate_completions_from_executable(bin/"drive2dav", "completion")
  end

  service do
    run [bin/"drive2dav", "serve"]
    keep_alive crashed: true
    log_path var/"log/drive2dav.log"
    error_log_path var/"log/drive2dav.log"
  end

  test do
    assert_match "drive2dav version #{version}", shell_output("#{bin}/drive2dav -v")
  end
end