# typed: false
# frozen_string_literal: true

# Homebrew formula for clawband — a PreToolUse hook for Claude Code that
# blocks destructive shell commands before they execute.
class Clawband < Formula
  desc "PreToolUse hook for Claude Code that blocks destructive shell commands"
  homepage "https://github.com/jamessoubry/clawband"
  version "2.16.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.16.0/clawband-macos-arm64"
      sha256 "aec0bc06e9a4916724138bc08ef350341a24029772ecb2968b8216de052b352d"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.16.0/clawband-macos-x86_64"
      sha256 "01f012ba2976d6ca0e82ef9cf7cf0c839e029eaab1d6041e45ed2833a1fb65a4"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.16.0/clawband-linux-x86_64"
      sha256 "2aa0ccaff1725e565a70f1ae07e1f6e52a8d3d94da873868fc6530506ca2c8f7"
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
