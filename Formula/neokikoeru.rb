class Neokikoeru < Formula
  desc "Self-hosted streaming media server for DLsite voice works"
  homepage "https://github.com/vscodev/neokikoeru"
  version "1.6.2"

  if OS.mac?
    if Hardware::CPU.arm? || Hardware::CPU.in_rosetta2?
      url "https://github.com/vscodev/neokikoeru/releases/download/v1.6.2/neokikoeru-macos-arm64.tar.gz"
      sha256 "56d31bbe151d8eec630fe47c65f8d11c542c7b6e9bb188b78f92f17a7b93b5ab"
    else
      url "https://github.com/vscodev/neokikoeru/releases/download/v1.6.2/neokikoeru-macos-amd64.tar.gz"
      sha256 "99c0d62d289402100b93125684ade44d4cad501ba73d42acad95e23841811ea3"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/vscodev/neokikoeru/releases/download/v1.6.2/neokikoeru-linux-arm64.tar.gz"
      sha256 "a1f3cd3bb35cc28a2668148e3ef3f74f361f235f695a048c2ddb52cc2fe637e5"
    else
      url "https://github.com/vscodev/neokikoeru/releases/download/v1.6.2/neokikoeru-linux-amd64.tar.gz"
      sha256 "2fad76339b5f71fbeefdd4062e0df64ef744a2073c918ad475cf430d757317f4"
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