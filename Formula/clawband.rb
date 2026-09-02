# typed: false
# frozen_string_literal: true

# Homebrew formula for clawband — a PreToolUse hook for Claude Code that
# blocks destructive shell commands before they execute.
class Clawband < Formula
  desc "PreToolUse hook for Claude Code that blocks destructive shell commands"
  homepage "https://github.com/jamessoubry/clawband"
  version "3.9.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v3.9.0/clawband-macos-arm64"
      sha256 "3b7f15db77f72c1ef7d04016dfd800220d71aef0cf3ae51c6e24bc364d1daf7d"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v3.9.0/clawband-macos-x86_64"
      sha256 "bbb40d5b56c46a29d05e1cef81b7645d506ff5b74dd24d2a46b01cec7db01f39"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v3.9.0/clawband-linux-arm64"
      sha256 "0442affee079038a32316ea9b0fb21489863cb6426920b3b20f0ecf912c05310"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v3.9.0/clawband-linux-x86_64"
      sha256 "91ab8a1f8a90442cf4cc11e5c810123e4841d4b4e477515a3cd82fb73a037e6f"
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
