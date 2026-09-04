# typed: false
# frozen_string_literal: true

# Homebrew formula for clawband — a PreToolUse hook for Claude Code that
# blocks destructive shell commands before they execute.
class Clawband < Formula
  desc "PreToolUse hook for Claude Code that blocks destructive shell commands"
  homepage "https://github.com/jamessoubry/clawband"
  version "3.14.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v3.14.0/clawband-macos-arm64"
      sha256 "baafd3a44fbfd13e7d20536864056b922388640190d834e00e115afd1340070f"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v3.14.0/clawband-macos-x86_64"
      sha256 "7d3bd05b87a672ed689b38ce33f825b5cc9dfe24857924f47ef12783886e679b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v3.14.0/clawband-linux-arm64"
      sha256 "8d91d4421251a48c5fb69e1a55685e4c1acd2061e90c1ac2ae20bd686700140c"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v3.14.0/clawband-linux-x86_64"
      sha256 "1880a73d3fe7aaec5a1752821983f87d19892d467900e0493631562c07078194"
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
