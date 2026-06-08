# typed: false
# frozen_string_literal: true

# Homebrew formula for clawband — a PreToolUse hook for Claude Code that
# blocks destructive shell commands before they execute.
class Clawband < Formula
  desc "PreToolUse hook for Claude Code that blocks destructive shell commands"
  homepage "https://github.com/jamessoubry/clawband"
  version "2.20.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.20.0/clawband-macos-arm64"
      sha256 "1a29dbc5d75f2075d620c9c5602a75dbdb9beb63ad7ab91f00a74cba5d0af33c"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.20.0/clawband-macos-x86_64"
      sha256 "23d090c0830ad799cbb97d197c329488de03d1784e0bcba48dbb8cf9d51223cb"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.20.0/clawband-linux-x86_64"
      sha256 "3e9c1bca5d28ae0b44a0ba18cfab57b1445c24eeb157751c0f19c1e407c27874"
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
