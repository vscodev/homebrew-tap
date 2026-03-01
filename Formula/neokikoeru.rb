class Neokikoeru < Formula
  desc "Cloud storage-based web media player for DLsite voice works"
  homepage "https://github.com/vscodev/neokikoeru"
  version "1.3.6"

  if OS.mac?
    if Hardware::CPU.arm? || Hardware::CPU.in_rosetta2?
      url "https://github.com/vscodev/neokikoeru/releases/download/v1.3.6/neokikoeru-macos-arm64.tar.gz"
      sha256 "38443e02b77bb5636930aafc4355c69f383273242abb37778bf260d85d189e59"
    else
      url "https://github.com/vscodev/neokikoeru/releases/download/v1.3.6/neokikoeru-macos-amd64.tar.gz"
      sha256 "bb666e78cf17fe17d3a17c93b3ce7da7efafb8437da6c887f6e2cc1fb788d701"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/vscodev/neokikoeru/releases/download/v1.3.6/neokikoeru-linux-arm64.tar.gz"
      sha256 "694ba61d3142f0b6d21f5c6219f080147c3d9c37a166b84dd328d746ebcc02f0"
    else
      url "https://github.com/vscodev/neokikoeru/releases/download/v1.3.6/neokikoeru-linux-amd64.tar.gz"
      sha256 "5646268ccb0d9cb3ceba97bca54fcf2980ba090a6b1bc777d38fca7cafa8bb11"
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