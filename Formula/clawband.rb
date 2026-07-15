# typed: false
# frozen_string_literal: true

# Homebrew formula for clawband — a PreToolUse hook for Claude Code that
# blocks destructive shell commands before they execute.
class Clawband < Formula
  desc "PreToolUse hook for Claude Code that blocks destructive shell commands"
  homepage "https://github.com/jamessoubry/clawband"
  version "2.99.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.99.0/clawband-macos-arm64"
      sha256 "611b8eb6dfc49bb9d7f31746484252ff79d8a5ce1b47d252748b96bc4b4c955b"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.99.0/clawband-macos-x86_64"
      sha256 "6cbef091c093a0930bb3ff24dc93d1b5cf330042361e48bfd2cc33c02d5bea1f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.99.0/clawband-linux-arm64"
      sha256 "5a3b7a53ea7c77dfcc42658af386d8785c0e0921f581318f421d3e8dffddaa82"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.99.0/clawband-linux-x86_64"
      sha256 "bb62718e48338eb11efce8781ce8666dae0a1de60ea43d94fd01f234c815cfa4"
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
