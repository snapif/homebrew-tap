class Snapif < Formula
  desc "Snapif scores one tool call and returns Auto, Review, or Escalate."
  homepage "https://github.com/snapif/snapif"
  version "0.2.11"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/snapif/snapif/releases/download/snapif-v0.2.11/snapif-aarch64-apple-darwin.tar.xz"
      sha256 "404c30c2e03a612a429340392baf923734c2e5c6a4db737ef7e46451374d9379"
    end
    if Hardware::CPU.intel?
      url "https://github.com/snapif/snapif/releases/download/snapif-v0.2.11/snapif-x86_64-apple-darwin.tar.xz"
      sha256 "3fd24f8d449d2f7e8ff83f01299e58dd0fd325d0bd3a5f536e1e1516a19de78f"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/snapif/snapif/releases/download/snapif-v0.2.11/snapif-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "69debcc224b58851cb1157139e6468463b7d0c58a22bd03cc82b7fc66c7f9a7b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/snapif/snapif/releases/download/snapif-v0.2.11/snapif-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "fa7a6a781b85f97938a5aebd3e1843b99f5d28316012a3684e5e0e0235ec6548"
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
