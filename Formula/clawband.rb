# typed: false
# frozen_string_literal: true

# Homebrew formula for clawband — a PreToolUse hook for Claude Code that
# blocks destructive shell commands before they execute.
class Clawband < Formula
  desc "PreToolUse hook for Claude Code that blocks destructive shell commands"
  homepage "https://github.com/jamessoubry/clawband"
  version "2.54.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.54.0/clawband-macos-arm64"
      sha256 "3bc8f89fabdfd025bc360da0460deadfd30323a31aed9a0f8072cb2562e39176"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.54.0/clawband-macos-x86_64"
      sha256 "ff42ce7219b153b4390ea0e3b6c5e99a9a1070e2f3cec8b564047e47df8dac17"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.54.0/clawband-linux-arm64"
      sha256 "af8d20854a5d7d1f1c468db5359b4f85ac4b5ca41d066534c7a2685585fc35ba"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.54.0/clawband-linux-x86_64"
      sha256 "7d82fc3f59251fcc213ad82c3643b0ed3816e900fc8afbe810ce358e38b70d94"
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
