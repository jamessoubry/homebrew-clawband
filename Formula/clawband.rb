# typed: false
# frozen_string_literal: true

# Homebrew formula for clawband — a PreToolUse hook for Claude Code that
# blocks destructive shell commands before they execute.
class Clawband < Formula
  desc "PreToolUse hook for Claude Code that blocks destructive shell commands"
  homepage "https://github.com/jamessoubry/clawband"
  version "2.49.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.49.0/clawband-macos-arm64"
      sha256 "5e5a54942b6f9ed13b13cfa4fb3d6623bb62661114b0b14edf1a49529f72531e"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.49.0/clawband-macos-x86_64"
      sha256 "77084c2b8723efd216d82f3f0098c6b5cea248e9ccdb91ce9a9dc863a1aab30c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.49.0/clawband-linux-arm64"
      sha256 "3bf8c9c4f1e60cf63386b9df991a5ceeb0c5c1675eb27c0f842c187cb97054fb"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.49.0/clawband-linux-x86_64"
      sha256 "0cf84dcf3e00c7381ad9822aa9dfced00a607246017e6909bb8989c4dd11bb6d"
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
