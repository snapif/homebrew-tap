class Snapif < Formula
  desc "Snapif scores one tool call and returns Auto, Review, or Escalate."
  homepage "https://github.com/snapif/snapif"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/snapif/snapif/releases/download/snapif-v0.2.0/snapif-aarch64-apple-darwin.tar.xz"
      sha256 "94c5c805bba1675b1bc0e2ec75c09ccc2517525724b453915f235f30f7db8cf3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/snapif/snapif/releases/download/snapif-v0.2.0/snapif-x86_64-apple-darwin.tar.xz"
      sha256 "129c63c48d25b962c808ff28914e340dc5336d7e348ff26d1d97da101e7df763"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/snapif/snapif/releases/download/snapif-v0.2.0/snapif-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "cca63e4c2201aa9e9d6f589080d34f1da0cd8af6f8bf50671b27bf2c1b4e0ce8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/snapif/snapif/releases/download/snapif-v0.2.0/snapif-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "41fff75e5fbce434a0e7700ee869379631d0418dabf0489a840e281bdbad901e"
    end
  end
  license any_of: ["MIT", "Apache-2.0"]

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "snapif"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "snapif"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "snapif"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "snapif"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
