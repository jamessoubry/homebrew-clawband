# typed: false
# frozen_string_literal: true

# Homebrew formula for clawband — a PreToolUse hook for Claude Code that
# blocks destructive shell commands before they execute.
class Clawband < Formula
  desc "PreToolUse hook for Claude Code that blocks destructive shell commands"
  homepage "https://github.com/jamessoubry/clawband"
  version "3.12.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v3.12.0/clawband-macos-arm64"
      sha256 "4a151fe930dc0a7959bae8c97f9937a492916af52970786c31440a21ddba74ea"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v3.12.0/clawband-macos-x86_64"
      sha256 "2cee1eccdef2960f064fee6b1fdd7a8446e14c2dafbac872c91b4b7c81860018"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v3.12.0/clawband-linux-arm64"
      sha256 "59e58699a9b309aa27c5bcba70c57f19c5bf005d22c93cacf7c64cf14bda10ad"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v3.12.0/clawband-linux-x86_64"
      sha256 "1579beef44f1912c351d7fc457f3e6fe8995c89f5597174ce043e5f6d659dd0a"
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
