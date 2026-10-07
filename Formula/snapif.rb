class Snapif < Formula
  desc "Snapif scores one tool call and returns Auto, Review, or Escalate."
  homepage "https://github.com/snapif/snapif"
  version "0.2.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/snapif/snapif/releases/download/snapif-v0.2.2/snapif-aarch64-apple-darwin.tar.xz"
      sha256 "3c8a89e95c51c71ed1d021c225bee5d68a16717af3f5fe43a77beac04c268953"
    end
    if Hardware::CPU.intel?
      url "https://github.com/snapif/snapif/releases/download/snapif-v0.2.2/snapif-x86_64-apple-darwin.tar.xz"
      sha256 "7bf1b92940ce66f70d9ba7c1130388b949b40b6851f372e81648328cb36c404e"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/snapif/snapif/releases/download/snapif-v0.2.2/snapif-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "f11b7704a9f603e2bf5de6914fc44fc8e6076a0f80ec750b460d24337fc21aaa"
    end
    if Hardware::CPU.intel?
      url "https://github.com/snapif/snapif/releases/download/snapif-v0.2.2/snapif-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "d1a50ccfc30262115b7077c71429ebaf2c6957104fe689a627d97181cbdce9c8"
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
