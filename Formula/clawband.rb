# typed: false
# frozen_string_literal: true

# Homebrew formula for clawband — a PreToolUse hook for Claude Code that
# blocks destructive shell commands before they execute.
class Clawband < Formula
  desc "PreToolUse hook for Claude Code that blocks destructive shell commands"
  homepage "https://github.com/jamessoubry/clawband"
  version "2.28.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.28.0/clawband-macos-arm64"
      sha256 "ce0e2d00497e0394ffd95624cf5d6f462e1d20d75c67177321a2a7b89ea0c271"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.28.0/clawband-macos-x86_64"
      sha256 "9baa124d8f029ac596e61c0254ef9dbd50e217e00649edfc300f4089adbf414f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.28.0/clawband-linux-arm64"
      sha256 "efc25db56e0a988405e63388e5258db1fd48ca4eb2abcc3acd49b66155b5bf55"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.28.0/clawband-linux-x86_64"
      sha256 "18e4e48dd3cf5d6cab636f0cf1138ef0ef44729d48c83ad5136d45fd2f04caf4"
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
