# typed: false
# frozen_string_literal: true

# Homebrew formula for clawband — a PreToolUse hook for Claude Code that
# blocks destructive shell commands before they execute.
class Clawband < Formula
  desc "PreToolUse hook for Claude Code that blocks destructive shell commands"
  homepage "https://github.com/jamessoubry/clawband"
  version "3.15.3"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v3.15.3/clawband-macos-arm64"
      sha256 "38ac66d984480ca5454bcb0adbda69bf9736874ee15f06d0677e93aaa42eb789"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v3.15.3/clawband-macos-x86_64"
      sha256 "2c1e2bf0f829cef34bd05ac6505c3fa4f54532124f62eb03e964d876f2b10b6d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v3.15.3/clawband-linux-arm64"
      sha256 "0ff266a675a66e6cadc4934f2e4176aaca8fd567aed356b36971f2c70d4a9fc5"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v3.15.3/clawband-linux-x86_64"
      sha256 "bc8a1a0735afb764f3653b51756fc533945b49b1192c6ebf13fd5e9f28353a53"
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
