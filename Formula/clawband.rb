# typed: false
# frozen_string_literal: true

# Homebrew formula for clawband — a PreToolUse hook for Claude Code that
# blocks destructive shell commands before they execute.
class Clawband < Formula
  desc "PreToolUse hook for Claude Code that blocks destructive shell commands"
  homepage "https://github.com/jamessoubry/clawband"
  version "2.44.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.44.0/clawband-macos-arm64"
      sha256 "53e458069d12d638a00ebffc23aa3a1d5838aad9dc8293ccb0ab87bca8be87c0"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.44.0/clawband-macos-x86_64"
      sha256 "3ecf7b0baa8803b32344ca6a4737d5674d5716c72b4f906dfa1ba5b2d7ef6e07"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.44.0/clawband-linux-arm64"
      sha256 "8cf653fdf6ddffda1b57231bb8fefb694b5aad4c6a3157c3c4f729b6b3e18977"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.44.0/clawband-linux-x86_64"
      sha256 "c316abfc92acc94af5c67a3c1376bfaede3c8baf2a6a75a25a0a31116d9d1761"
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
