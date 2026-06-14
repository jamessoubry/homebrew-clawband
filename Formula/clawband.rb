# typed: false
# frozen_string_literal: true

# Homebrew formula for clawband — a PreToolUse hook for Claude Code that
# blocks destructive shell commands before they execute.
class Clawband < Formula
  desc "PreToolUse hook for Claude Code that blocks destructive shell commands"
  homepage "https://github.com/jamessoubry/clawband"
  version "2.59.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.59.0/clawband-macos-arm64"
      sha256 "15d9a5669508b921390d0f3a17263d0224aef16c4e9d342bb8b3bc0a068c3181"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.59.0/clawband-macos-x86_64"
      sha256 "ed8daff154ee86a6a1dd680d1c59efaf42b354a3114cf6203af3f12b395e30f8"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.59.0/clawband-linux-arm64"
      sha256 "8ab3fe7a5174b0c82f4448172b44b71f3206d255a690e8c00b49edf42289104a"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.59.0/clawband-linux-x86_64"
      sha256 "843ed25dabaaad65ac2c92dac3e6eb9a9c2db0b37034598ab1819621df735946"
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
