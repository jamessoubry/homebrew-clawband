# typed: false
# frozen_string_literal: true

# Homebrew formula for clawband — a PreToolUse hook for Claude Code that
# blocks destructive shell commands before they execute.
class Clawband < Formula
  desc "PreToolUse hook for Claude Code that blocks destructive shell commands"
  homepage "https://github.com/jamessoubry/clawband"
  version "2.63.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.63.0/clawband-macos-arm64"
      sha256 "d9c09b97a15f7d90d660c1bae50d8b3a23aed6db15c8b350ec1c1c2179074934"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.63.0/clawband-macos-x86_64"
      sha256 "8348373ebc2c98ee995504b93aee985aa2f3ee471bd16c71eeb4bf61720075b5"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.63.0/clawband-linux-arm64"
      sha256 "de8fed9fa95e151e745525946532c37e6269ef78fbfeb30f132329250bed69ad"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.63.0/clawband-linux-x86_64"
      sha256 "1c7c86d17d454d2a4daa82a8982ea2492a134dfabd5b70315d8ab789dd501fef"
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
