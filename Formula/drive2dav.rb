class Drive2dav < Formula
  desc "A lightweight WebDAV server that supports multiple storages"
  homepage "https://github.com/vscodev/drive2dav"
  version "0.0.9"

  if OS.mac?
    if Hardware::CPU.arm? || Hardware::CPU.in_rosetta2?
      url "https://github.com/vscodev/drive2dav/releases/download/v0.0.9/drive2dav-macos-arm64.tar.gz"
      sha256 "c9c99febcf3c31bd01c81c42a1981e760e3a002e9185cb7ec877deff91928e37"
    else
      url "https://github.com/vscodev/drive2dav/releases/download/v0.0.9/drive2dav-macos-amd64.tar.gz"
      sha256 "5d05260c14002ce9d9790ae28e6a4788ab6fc9ca054633c1c35780d1c8e67289"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/vscodev/drive2dav/releases/download/v0.0.9/drive2dav-linux-arm64.tar.gz"
      sha256 "59979de4bea28c4870c2e1e1877e75e10ea8161d2c1da0b0b770e8648e981396"
    else
      url "https://github.com/vscodev/drive2dav/releases/download/v0.0.9/drive2dav-linux-amd64.tar.gz"
      sha256 "b39b6abc2f797e74ac1e00de45389b74294678baeecbca96c331341c0fd97ead"
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