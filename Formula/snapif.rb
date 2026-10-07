class Snapif < Formula
  desc "Snapif scores one tool call and returns Auto, Review, or Escalate."
  homepage "https://github.com/snapif/snapif"
  version "0.2.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/snapif/snapif/releases/download/snapif-v0.2.3/snapif-aarch64-apple-darwin.tar.xz"
      sha256 "e447350fc5e6c253af6e796dfdf5669ece07ddb889a62033d851d1b7bf55ec6c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/snapif/snapif/releases/download/snapif-v0.2.3/snapif-x86_64-apple-darwin.tar.xz"
      sha256 "d09b34d7427a6c07e09950a47e8a4f57e969c331f82166de57e0c7d88f0b2bc4"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/snapif/snapif/releases/download/snapif-v0.2.3/snapif-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "475f7c9d538609a59ce851814e2d6b1ec67f9768dcd4b9ebf28cb636e5c87d79"
    end
    if Hardware::CPU.intel?
      url "https://github.com/snapif/snapif/releases/download/snapif-v0.2.3/snapif-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "f72d540b7cbe0528886bc1dbe22e2a2bea372ef95435783b3f64593695aa35e5"
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
