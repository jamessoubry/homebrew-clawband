# typed: false
# frozen_string_literal: true

# Homebrew formula for clawband — a PreToolUse hook for Claude Code that
# blocks destructive shell commands before they execute.
class Clawband < Formula
  desc "PreToolUse hook for Claude Code that blocks destructive shell commands"
  homepage "https://github.com/jamessoubry/clawband"
  version "2.41.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.41.0/clawband-macos-arm64"
      sha256 "cf772dd1556a41295f73766554779be94e78e4891a9a69cd13ea01f8844df95f"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.41.0/clawband-macos-x86_64"
      sha256 "90ef981e58928ac4cbad59dec5997fa117a68e6b3c66bb98d78eceae8bf959a4"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.41.0/clawband-linux-arm64"
      sha256 "6b92606cfba7852905caba5eafb8646088a2ff45a96ba91f16912ed07cf85bba"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.41.0/clawband-linux-x86_64"
      sha256 "2a9db6eae31208d1dab6a5bc6000681af275a01b455fe06a79224be9b1466389"
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
