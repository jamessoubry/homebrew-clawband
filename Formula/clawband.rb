# typed: false
# frozen_string_literal: true

# Homebrew formula for clawband — a PreToolUse hook for Claude Code that
# blocks destructive shell commands before they execute.
class Clawband < Formula
  desc "PreToolUse hook for Claude Code that blocks destructive shell commands"
  homepage "https://github.com/jamessoubry/clawband"
  version "2.50.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.50.0/clawband-macos-arm64"
      sha256 "ad75e2b70f560761bf6aab010108e9d6a4d2367db16a56257d62e05b3ff17c6b"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.50.0/clawband-macos-x86_64"
      sha256 "eb91df516455efd67e7c7c7799bd6e55cdb617fa8926eeb929ef595a10788f77"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.50.0/clawband-linux-arm64"
      sha256 "1f410e424a57efef8bb813a462efd3e92d272a5368b72ca564edf88890d4d7f9"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.50.0/clawband-linux-x86_64"
      sha256 "792d7bcb816c9dee008473310d08209fae851cad2c3fb8f460911eff0ea91fbe"
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
