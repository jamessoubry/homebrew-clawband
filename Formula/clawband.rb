# typed: false
# frozen_string_literal: true

# Homebrew formula for clawband — a PreToolUse hook for Claude Code that
# blocks destructive shell commands before they execute.
class Clawband < Formula
  desc "PreToolUse hook for Claude Code that blocks destructive shell commands"
  homepage "https://github.com/jamessoubry/clawband"
  version "2.24.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.24.0/clawband-macos-arm64"
      sha256 "cb0a0e347659ea03fec18f677834da551bce15c0d1e3bdb91e0251daeb0a9a50"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.24.0/clawband-macos-x86_64"
      sha256 "ce06dc562f8cf65954f97e050760d63d36dac2e143e8f989c7d504038faf84c0"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.24.0/clawband-linux-x86_64"
      sha256 "682f34ef52eeed5326e531da0ad936f8cad065f3f27ce11265bbb7c97a7b5bfe"
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
