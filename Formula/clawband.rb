# typed: false
# frozen_string_literal: true

# Homebrew formula for clawband — a PreToolUse hook for Claude Code that
# blocks destructive shell commands before they execute.
class Clawband < Formula
  desc "PreToolUse hook for Claude Code that blocks destructive shell commands"
  homepage "https://github.com/jamessoubry/clawband"
  version "2.15.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.15.0/clawband-macos-arm64"
      sha256 "be6ab96a3b48fcbcb457bfdac6a6101406d03f3da38d8e41d416183d26a6d8d4"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.15.0/clawband-macos-x86_64"
      sha256 "2d70102fdaad3fc2900c3659c695d29ca20a89e441185e009ba960cde6647af2"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.15.0/clawband-linux-x86_64"
      sha256 "1e4e7849ff53ab56e7831b412acc7ff434d9872a59b41f7506bb2d0de166990d"
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
