# typed: false
# frozen_string_literal: true

# Homebrew formula for clawband — a PreToolUse hook for Claude Code that
# blocks destructive shell commands before they execute.
class Clawband < Formula
  desc "PreToolUse hook for Claude Code that blocks destructive shell commands"
  homepage "https://github.com/jamessoubry/clawband"
  version "3.10.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v3.10.0/clawband-macos-arm64"
      sha256 "8a19eeb9766cbcd1768fd600210704767ae931a06fa44e9c0bea8bed05726bcd"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v3.10.0/clawband-macos-x86_64"
      sha256 "6e502fb7d91df854699d6807b2249df6dea94a5b76f786a85faa53f202f0c871"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v3.10.0/clawband-linux-arm64"
      sha256 "f556e8ce9aeb3f8d27aa902557d04dc91bad1faee89966e4e0a1fd181c9fe053"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v3.10.0/clawband-linux-x86_64"
      sha256 "73e6ef26afcb2bd3ea5a2c99cee043bb54e8ed791c423f77e97017bd1e6a6781"
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
