class Drive2dav < Formula
  desc "A lightweight WebDAV server that supports multiple storages"
  homepage "https://github.com/vscodev/drive2dav"
  version "0.1.0"

  if OS.mac?
    if Hardware::CPU.arm? || Hardware::CPU.in_rosetta2?
      url "https://github.com/vscodev/drive2dav/releases/download/v0.1.0/drive2dav-macos-arm64.tar.gz"
      sha256 "1155475b8283955ec09e7c40bbb675c06f9b726808d5c0a0081b6dc2f5729adb"
    else
      url "https://github.com/vscodev/drive2dav/releases/download/v0.1.0/drive2dav-macos-amd64.tar.gz"
      sha256 "34bee6ba16f15e11db8cee3a37ccdde8bc02f9a9f2208c0b1296a46b65ab7146"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/vscodev/drive2dav/releases/download/v0.1.0/drive2dav-linux-arm64.tar.gz"
      sha256 "5ec37d71d5c27d2af1eb2134f34d1cae9ef7ed9e324b45a0bf1b208bd54a0cf1"
    else
      url "https://github.com/vscodev/drive2dav/releases/download/v0.1.0/drive2dav-linux-amd64.tar.gz"
      sha256 "34a06dfd7adfe1c36da36686be3c3df4b6e77b2d5a28e0cd9c37b6ff9f4d960b"
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