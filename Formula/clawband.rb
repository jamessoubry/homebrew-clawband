# typed: false
# frozen_string_literal: true

# Homebrew formula for clawband — a PreToolUse hook for Claude Code that
# blocks destructive shell commands before they execute.
class Clawband < Formula
  desc "PreToolUse hook for Claude Code that blocks destructive shell commands"
  homepage "https://github.com/jamessoubry/clawband"
  version "2.64.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.64.0/clawband-macos-arm64"
      sha256 "f91ddc9ffd566611d386324b43ef1f829a19605005752cce97e2210a94be5c32"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.64.0/clawband-macos-x86_64"
      sha256 "8743d1ecb190c3a5c0129765f6ffa5eb783c3b16af085c11bdee2a9705b8d3ed"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.64.0/clawband-linux-arm64"
      sha256 "e2c65adc5dff4319ca1499b8341638a0f73187d6eebb8a24940a3bdda802f1b4"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.64.0/clawband-linux-x86_64"
      sha256 "92178500636aee122fa855520ea89ad0b5bf7d78409811c8b6b3bf7a54a933d7"
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
