class Drive2dav < Formula
  desc "A lightweight WebDAV server that supports multiple storages"
  homepage "https://github.com/vscodev/drive2dav"
  version "0.0.7"

  if OS.mac?
    if Hardware::CPU.arm? || Hardware::CPU.in_rosetta2?
      url "https://github.com/vscodev/drive2dav/releases/download/v0.0.7/drive2dav-macos-arm64.tar.gz"
      sha256 "de52811c065257046404ea2922cc3dc574bc1e94c3c63b19858a550bd2d653f3"
    else
      url "https://github.com/vscodev/drive2dav/releases/download/v0.0.7/drive2dav-macos-amd64.tar.gz"
      sha256 "558221d7ced27d2e337f806787d3c74d407887c8216857ec2644e60541f51186"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/vscodev/drive2dav/releases/download/v0.0.7/drive2dav-linux-arm64.tar.gz"
      sha256 "cfa3df78c9c3d7e61d21824f85e0793028a4682e872ff370c7ae83e03ca46f89"
    else
      url "https://github.com/vscodev/drive2dav/releases/download/v0.0.7/drive2dav-linux-amd64.tar.gz"
      sha256 "c14b87b2bd4f0a3a10f5377db1609b8b2c1dafe214ee01e529935a442a24303b"
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