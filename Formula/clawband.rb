# typed: false
# frozen_string_literal: true

# Homebrew formula for clawband — a PreToolUse hook for Claude Code that
# blocks destructive shell commands before they execute.
class Clawband < Formula
  desc "PreToolUse hook for Claude Code that blocks destructive shell commands"
  homepage "https://github.com/jamessoubry/clawband"
  version "3.7.11"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v3.7.11/clawband-macos-arm64"
      sha256 "f21ef71dbacba0709b828fee3a876f11c28e71c14f64fc28aaeb4aeedc2c5cc9"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v3.7.11/clawband-macos-x86_64"
      sha256 "45fa3f74b1faec02bdf75e1761044004ae41e5175998b75c8a2e3fbdf5c1910b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v3.7.11/clawband-linux-arm64"
      sha256 "515e1372d329c28c880075914ede0ab03c7fcb23d7612d7bebef358f2b90cdda"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v3.7.11/clawband-linux-x86_64"
      sha256 "1e42e2a4ac8954a5b67784241081970f0e3f1ff853c4b123b4c2f1578b7c184c"
    end
  end

  def install
    # The downloaded asset is a bare binary named per-platform; install as "clawband".
    bin.install Dir["clawband-*"].first => "clawband"
  end

  def caveats
    <<~CAVEAT
      clawband is installed, but it is not yet wired into Claude Code.

      Run:

        clawband install   # registers the PreToolUse hook + seeds ~/.clawband/
        clawband verify    # confirm it's active

      Then run /hooks in Claude Code (or restart) to activate.
      See: https://github.com/jamessoubry/clawband#installation
    CAVEAT
  end

  test do
    assert_match "clawband v#{version}", shell_output("#{bin}/clawband --version")
  end
end
