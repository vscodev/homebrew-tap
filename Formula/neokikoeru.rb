class Neokikoeru < Formula
  desc "Cloud storage-based web media player for DLsite voice works"
  homepage "https://github.com/vscodev/neokikoeru"
  version "1.3.9"

  if OS.mac?
    if Hardware::CPU.arm? || Hardware::CPU.in_rosetta2?
      url "https://github.com/vscodev/neokikoeru/releases/download/v1.3.9/neokikoeru-macos-arm64.tar.gz"
      sha256 "08508c720984d40aae5fd745ec7761be78c71875d5218ec78645e7cf1ee17d9c"
    else
      url "https://github.com/vscodev/neokikoeru/releases/download/v1.3.9/neokikoeru-macos-amd64.tar.gz"
      sha256 "a803c2fe58f4c7bdb8c4ca003fbe4dba82f4c0a7db28b520566050d95c41d533"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/vscodev/neokikoeru/releases/download/v1.3.9/neokikoeru-linux-arm64.tar.gz"
      sha256 "e2d79483879d338a39d904f8acb8ec1e6003b6320e98a3aa82c8461ddf758402"
    else
      url "https://github.com/vscodev/neokikoeru/releases/download/v1.3.9/neokikoeru-linux-amd64.tar.gz"
      sha256 "27b64846f9a07651e853f521fb527bcd952adc2ce54317a326c4226af36b31fb"
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