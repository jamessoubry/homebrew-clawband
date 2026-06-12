# typed: false
# frozen_string_literal: true

# Homebrew formula for clawband — a PreToolUse hook for Claude Code that
# blocks destructive shell commands before they execute.
class Clawband < Formula
  desc "PreToolUse hook for Claude Code that blocks destructive shell commands"
  homepage "https://github.com/jamessoubry/clawband"
  version "2.37.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.37.0/clawband-macos-arm64"
      sha256 "78bacfaab5a563561e965a30911acf665aa1f8aa12c34480d565094b8de45cf3"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.37.0/clawband-macos-x86_64"
      sha256 "c19cb5b7d4e1b409960a1502896d03da84539b9e0955a90449b4cbeda22c3b4e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.37.0/clawband-linux-arm64"
      sha256 "8a3865287712d6e77fc514f7f72c8d3f24d8e7f6e9a6a77862b68c51f05817da"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.37.0/clawband-linux-x86_64"
      sha256 "8a756f6bf6a95ad9a990ea1863da228cac17ba7eb3ebaad79b94501822fa6fd8"
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
