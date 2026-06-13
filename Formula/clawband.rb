# typed: false
# frozen_string_literal: true

# Homebrew formula for clawband — a PreToolUse hook for Claude Code that
# blocks destructive shell commands before they execute.
class Clawband < Formula
  desc "PreToolUse hook for Claude Code that blocks destructive shell commands"
  homepage "https://github.com/jamessoubry/clawband"
  version "2.48.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.48.0/clawband-macos-arm64"
      sha256 "83a4a3d7cda57b2aee6a8a3e5c4098286e4a8d4838d03a3e804a9d15978eec81"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.48.0/clawband-macos-x86_64"
      sha256 "dee2e1fa1a0b0b8c1b09a45461ddd480df785d1a7755723af4258ed384660acc"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.48.0/clawband-linux-arm64"
      sha256 "77581e67d289146611ab7071cfa7f93cc6256a9f187b2a586256bfb0a19c85be"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.48.0/clawband-linux-x86_64"
      sha256 "ed4a418bd6f36b343f6e2c6ab9241ef930a37d430d6faf2b168cbc9d6e660f8f"
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
