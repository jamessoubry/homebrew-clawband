# typed: false
# frozen_string_literal: true

# Homebrew formula for clawband — a PreToolUse hook for Claude Code that
# blocks destructive shell commands before they execute.
class Clawband < Formula
  desc "PreToolUse hook for Claude Code that blocks destructive shell commands"
  homepage "https://github.com/jamessoubry/clawband"
  version "2.45.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.45.0/clawband-macos-arm64"
      sha256 "860efa9c5d861ee0bb0a5a730c79848fca965260ca25bf10589779325e095538"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.45.0/clawband-macos-x86_64"
      sha256 "bd3670f36c9c876f25bbf6d10fe73822ca4ff410ac652bc88bb4f5d519495fcb"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.45.0/clawband-linux-arm64"
      sha256 "b91938b984c46d4f0fa720f6c98be568b12f0d92f64b0155e3a70704efc0b766"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.45.0/clawband-linux-x86_64"
      sha256 "1c6e7d84dbaeaf86ea597f79c98c9680dc62b0183bfb0664b75dc91fda6ccd5e"
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
