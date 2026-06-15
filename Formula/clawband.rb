# typed: false
# frozen_string_literal: true

# Homebrew formula for clawband — a PreToolUse hook for Claude Code that
# blocks destructive shell commands before they execute.
class Clawband < Formula
  desc "PreToolUse hook for Claude Code that blocks destructive shell commands"
  homepage "https://github.com/jamessoubry/clawband"
  version "2.68.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.68.0/clawband-macos-arm64"
      sha256 "15e6a805f3e2c61e6bf8c3efcd232bb35d5a2bab806a2f2a582dacf32f7d5f71"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.68.0/clawband-macos-x86_64"
      sha256 "d8cb13124358ce25b8f99e1c5b343f27b40e1ed99270d6f309b4b45dcb5567e5"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.68.0/clawband-linux-arm64"
      sha256 "b952051c54e7b4bf8d07feb2bc8fa5be56c990d252774ef6c5eefb95ebce4d90"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.68.0/clawband-linux-x86_64"
      sha256 "f50c87b46f12a948cb7272bbac4bd5c0c855ca33cf8c845f2f184e1f1dc2e6b3"
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
