# typed: false
# frozen_string_literal: true

# Homebrew formula for clawband — a PreToolUse hook for Claude Code that
# blocks destructive shell commands before they execute.
class Clawband < Formula
  desc "PreToolUse hook for Claude Code that blocks destructive shell commands"
  homepage "https://github.com/jamessoubry/clawband"
  version "2.47.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.47.0/clawband-macos-arm64"
      sha256 "fc2aeaee478d0a18529d881a9d8c60b43953191180ed2aee3871890649daa536"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.47.0/clawband-macos-x86_64"
      sha256 "023ba357c0653cfb22f2d5734d919259c0f047c065974ca7aa9059b2e0570749"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.47.0/clawband-linux-arm64"
      sha256 "c7fcf2dc26d30619f8081f6f89ad8b694a3e074bf210ab17a01c4307beca1404"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.47.0/clawband-linux-x86_64"
      sha256 "f5a0d6dca8185cb9cdda3c166a95bbaae0799a2c7c2d4f285eb00f5a3a5c5737"
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
