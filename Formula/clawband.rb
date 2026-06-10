# typed: false
# frozen_string_literal: true

# Homebrew formula for clawband — a PreToolUse hook for Claude Code that
# blocks destructive shell commands before they execute.
class Clawband < Formula
  desc "PreToolUse hook for Claude Code that blocks destructive shell commands"
  homepage "https://github.com/jamessoubry/clawband"
  version "2.27.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.27.0/clawband-macos-arm64"
      sha256 "a4f93277b664f1e178d833b24cb3a50da0e53ad591bd3df35ca431421cf48c68"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.27.0/clawband-macos-x86_64"
      sha256 "d41867237345b350d5626cc7ef97a6493fb8911c0fb9ea17c8970d0c6d5f6ef3"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.27.0/clawband-linux-x86_64"
      sha256 "ab6ee5944598dac5602ecd50d843d5eb2e83c16eff991b3073dfa886f3c18c85"
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
