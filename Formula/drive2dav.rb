class Drive2dav < Formula
  desc "A lightweight WebDAV server that supports multiple storages"
  homepage "https://github.com/vscodev/drive2dav"
  version "0.3.2"

  if OS.mac?
    if Hardware::CPU.arm? || Hardware::CPU.in_rosetta2?
      url "https://github.com/vscodev/drive2dav/releases/download/v0.3.2/drive2dav-macos-arm64.tar.gz"
      sha256 "01043435fb9be763ffedbfffbe4161b78522a7f500a14ed62f53c072cd1c9878"
    else
      url "https://github.com/vscodev/drive2dav/releases/download/v0.3.2/drive2dav-macos-amd64.tar.gz"
      sha256 "886c058295192378da28429a85f7ffd3069244dfe63e417c3d8cfa80f66c3176"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/vscodev/drive2dav/releases/download/v0.3.2/drive2dav-linux-arm64.tar.gz"
      sha256 "0380b2207e770fd309b83acccbe8f46dec49c955fee741f79caa455e72f635f8"
    else
      url "https://github.com/vscodev/drive2dav/releases/download/v0.3.2/drive2dav-linux-amd64.tar.gz"
      sha256 "eae84cc6a2eca57bf065ee3e8b6fba988e07b7312329866b19a907cffc7a0f83"
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