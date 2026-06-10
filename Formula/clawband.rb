# typed: false
# frozen_string_literal: true

# Homebrew formula for clawband — a PreToolUse hook for Claude Code that
# blocks destructive shell commands before they execute.
class Clawband < Formula
  desc "PreToolUse hook for Claude Code that blocks destructive shell commands"
  homepage "https://github.com/jamessoubry/clawband"
  version "2.26.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.26.0/clawband-macos-arm64"
      sha256 "dc5b04bed0e4481be7cabaa1c668fa3d224f5d56964dc472891170b4eb062145"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.26.0/clawband-macos-x86_64"
      sha256 "9930a5b36cfe0836658d6d4f4c4c4e17e839cfe306493dfe7be7f1fcbfe1632b"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.26.0/clawband-linux-x86_64"
      sha256 "f1885048ae147781d7d457709ed1f1c11e4654300f221e5bd5726c95a37aee1f"
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
