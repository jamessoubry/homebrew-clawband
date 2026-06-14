# typed: false
# frozen_string_literal: true

# Homebrew formula for clawband — a PreToolUse hook for Claude Code that
# blocks destructive shell commands before they execute.
class Clawband < Formula
  desc "PreToolUse hook for Claude Code that blocks destructive shell commands"
  homepage "https://github.com/jamessoubry/clawband"
  version "2.65.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.65.0/clawband-macos-arm64"
      sha256 "91eccf3f7ed81b072446a5f53abf71c34b2f24e459a3a900039b57711cc59c7b"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.65.0/clawband-macos-x86_64"
      sha256 "a683a520f2da2fc1ea44e6f44f4ab000e6297524ff2d4a5911b02f6eae1fc069"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.65.0/clawband-linux-arm64"
      sha256 "cfb8eeb28b5c60817944a06ab61e04f2457bf6d9e0114c0b52031d73ad72432e"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.65.0/clawband-linux-x86_64"
      sha256 "643d6e172b7624ee067491010e8b8f1365eccbd08c5c1db57e03725588abaf0a"
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
