class Snapif < Formula
  desc "Snapif scores one tool call and returns Auto, Review, or Escalate."
  homepage "https://github.com/snapif/snapif"
  version "0.2.7"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/snapif/snapif/releases/download/snapif-v0.2.7/snapif-aarch64-apple-darwin.tar.xz"
      sha256 "3884c77a75203a5e86312972f6369c68fa444fd323eaa3130a56228cc37d0f5c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/snapif/snapif/releases/download/snapif-v0.2.7/snapif-x86_64-apple-darwin.tar.xz"
      sha256 "6c34ba0c0e097a0cc720d14083fc04b857331fffd459563767bc2aa3ee1a76bd"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/snapif/snapif/releases/download/snapif-v0.2.7/snapif-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "3a60aad1699228faf67fd45b31e134e3771a2fa2e6f08d15820a580ce1889121"
    end
    if Hardware::CPU.intel?
      url "https://github.com/snapif/snapif/releases/download/snapif-v0.2.7/snapif-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "707a77adcc164420c998cbc5e2b00464d19ae851615668843a206daa485d5ad2"
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
