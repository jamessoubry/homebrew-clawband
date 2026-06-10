# typed: false
# frozen_string_literal: true

# Homebrew formula for clawband — a PreToolUse hook for Claude Code that
# blocks destructive shell commands before they execute.
class Clawband < Formula
  desc "PreToolUse hook for Claude Code that blocks destructive shell commands"
  homepage "https://github.com/jamessoubry/clawband"
  version "2.25.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.25.0/clawband-macos-arm64"
      sha256 "f1ec3848c013a54f80ea9af1c5e2df31232a2220b34bdb5ba7f1cabbd0eb70bd"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.25.0/clawband-macos-x86_64"
      sha256 "3d2ec45acee8b3668310189d47fc1eaf2492a734e3c549373c73defd869f45a2"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.25.0/clawband-linux-x86_64"
      sha256 "f63a2d969c828b8b57969b55e572ef5f1bc5ed078ff0b4c34a60c486b6e9339e"
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
