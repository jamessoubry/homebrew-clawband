# typed: false
# frozen_string_literal: true

# Homebrew formula for clawband — a PreToolUse hook for Claude Code that
# blocks destructive shell commands before they execute.
class Clawband < Formula
  desc "PreToolUse hook for Claude Code that blocks destructive shell commands"
  homepage "https://github.com/jamessoubry/clawband"
  version "2.38.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.38.0/clawband-macos-arm64"
      sha256 "ae22454e0291756559aee85a8f95b5e6856df2cd1075a14cab1c126890a0e530"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.38.0/clawband-macos-x86_64"
      sha256 "7f9ced31ad01875ba5015803501855d1e701f0e31739e4a859ca680094d6a6d5"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.38.0/clawband-linux-arm64"
      sha256 "17763248588b30447020dc4f9917ca9a41e6e8e13f51394542923937e9bf3614"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.38.0/clawband-linux-x86_64"
      sha256 "9941ff0d9bdb53fd069922a1efdc2ea912697e358a5d3c5e8a38c9ce0106fcc6"
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
