# typed: false
# frozen_string_literal: true

# Homebrew formula for clawband — a PreToolUse hook for Claude Code that
# blocks destructive shell commands before they execute.
class Clawband < Formula
  desc "PreToolUse hook for Claude Code that blocks destructive shell commands"
  homepage "https://github.com/jamessoubry/clawband"
  version "2.71.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.71.0/clawband-macos-arm64"
      sha256 "a764a6e28b46b936c5723658b1779f81f16928985d0ed71daf37e2f139138017"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.71.0/clawband-macos-x86_64"
      sha256 "ae02e2c0ac449b9e73c6e3aff84b8acfe84d7d902355e7273a75fd1565bb2fe9"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.71.0/clawband-linux-arm64"
      sha256 "fea8ea25d3265ed4e1fd4cf8a2a0ac64145f991b8adf0f20007ba788e4afd532"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.71.0/clawband-linux-x86_64"
      sha256 "f0ee1143d2abd00799befc3c5168239891d48116c7e67b9f8ef56ec545e79b8e"
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
