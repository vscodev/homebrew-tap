class Neokikoeru < Formula
  desc "Cloud storage-based web media player for DLsite voice works"
  homepage "https://github.com/vscodev/neokikoeru"
  version "1.3.8"

  if OS.mac?
    if Hardware::CPU.arm? || Hardware::CPU.in_rosetta2?
      url "https://github.com/vscodev/neokikoeru/releases/download/v1.3.8/neokikoeru-macos-arm64.tar.gz"
      sha256 "1b5102e7d1b6fa44fdc6caf27d49ae7d6cd92bce6ef30c70774779ad1289e60c"
    else
      url "https://github.com/vscodev/neokikoeru/releases/download/v1.3.8/neokikoeru-macos-amd64.tar.gz"
      sha256 "ead440bf891cc70f5c24a454cd512a31d6f8e08a818e7a11db74ca28eee4f3d5"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/vscodev/neokikoeru/releases/download/v1.3.8/neokikoeru-linux-arm64.tar.gz"
      sha256 "98a2f1567a0437cffceb9e5b3cdb36c708c34111a9e15c52339b43de39cb0f6b"
    else
      url "https://github.com/vscodev/neokikoeru/releases/download/v1.3.8/neokikoeru-linux-amd64.tar.gz"
      sha256 "3d5f26c60263a1c3f308529747de82850f44aa75b691252b7b08fe68d716dfa7"
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