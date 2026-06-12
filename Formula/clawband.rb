# typed: false
# frozen_string_literal: true

# Homebrew formula for clawband — a PreToolUse hook for Claude Code that
# blocks destructive shell commands before they execute.
class Clawband < Formula
  desc "PreToolUse hook for Claude Code that blocks destructive shell commands"
  homepage "https://github.com/jamessoubry/clawband"
  version "2.40.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.40.0/clawband-macos-arm64"
      sha256 "a606cd660b6ad1e75e3937edf2faa3de3da4ff157d716e5e752a3795bc62c28d"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.40.0/clawband-macos-x86_64"
      sha256 "f825fb613d980a429b24c424ef65db3b99de18e4253ded7e05b856a0f4bf32c2"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.40.0/clawband-linux-arm64"
      sha256 "e557fad381304902bcb7c0f248ba9fe3c064d0b979f7023d1db010be53654bdd"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.40.0/clawband-linux-x86_64"
      sha256 "cf6aff13d2dcda6dfc11a9d09908363f7e9ea59229e297a635754b672a378462"
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
