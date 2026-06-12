# typed: false
# frozen_string_literal: true

# Homebrew formula for clawband — a PreToolUse hook for Claude Code that
# blocks destructive shell commands before they execute.
class Clawband < Formula
  desc "PreToolUse hook for Claude Code that blocks destructive shell commands"
  homepage "https://github.com/jamessoubry/clawband"
  version "2.42.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.42.0/clawband-macos-arm64"
      sha256 "031fd7d7e2607d7ee9fd423161030ab47e2d6b7c27a6895647f310d1d9900755"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.42.0/clawband-macos-x86_64"
      sha256 "3df4020b21358c067555c21b91a141336a676a56e60f7734fc7508459b257f90"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.42.0/clawband-linux-arm64"
      sha256 "31f090ab8d5c76162f0fb672dd246b1ccf538cdd1afdefe442d2b38914581ee1"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.42.0/clawband-linux-x86_64"
      sha256 "7e8534819964bcca43cd8b80db5a00035d4e24db10a512c6bc9adf99eb9ffdc0"
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
