class Neokikoeru < Formula
  desc "High-performance streaming media server for DLsite voice works"
  homepage "https://github.com/vscodev/neokikoeru"
  version "3.32.5"

  if OS.mac?
    if Hardware::CPU.arm? || Hardware::CPU.in_rosetta2?
      url "https://github.com/vscodev/neokikoeru/releases/download/v3.32.5/neokikoeru-macos-arm64.tar.gz"
      sha256 "a1046d83690700419e041c1730c904720506a7e95d42d6dda99e31db0c366842"
    else
      url "https://github.com/vscodev/neokikoeru/releases/download/v3.32.5/neokikoeru-macos-amd64.tar.gz"
      sha256 "f6da2a8dd9b2bac52f387027752aecea050ff788dc5955fe1c87f2714989c29c"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/vscodev/neokikoeru/releases/download/v3.32.5/neokikoeru-linux-arm64.tar.gz"
      sha256 "e52afb3de3818b0bae1a509573d21fadb88f01a4cef636aa068cdecfdc4a3952"
    else
      url "https://github.com/vscodev/neokikoeru/releases/download/v3.32.5/neokikoeru-linux-amd64.tar.gz"
      sha256 "db898fb598fcbf441f1773dd073972def2609021bd4150e533b58039dcc5f215"
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