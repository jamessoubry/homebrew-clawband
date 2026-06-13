# typed: false
# frozen_string_literal: true

# Homebrew formula for clawband — a PreToolUse hook for Claude Code that
# blocks destructive shell commands before they execute.
class Clawband < Formula
  desc "PreToolUse hook for Claude Code that blocks destructive shell commands"
  homepage "https://github.com/jamessoubry/clawband"
  version "2.53.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.53.0/clawband-macos-arm64"
      sha256 "d86bbf4c94eb694b2b97049665ccf110de40673c42ba3f8cbf9345025809c72d"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.53.0/clawband-macos-x86_64"
      sha256 "852dce94bb929fd71fd2dbea75bce16012326b93c1b95e6937b638f09e50627d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.53.0/clawband-linux-arm64"
      sha256 "4188f18d05e9afbd5e7c5ea74e132329a63d730bdf9576a80eea1887d8b85c5e"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.53.0/clawband-linux-x86_64"
      sha256 "75fe9b3f6f8265bd9be124fb7fb5d2ec621639bd6d16bc6eae7547628020031c"
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
