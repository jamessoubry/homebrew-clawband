# typed: false
# frozen_string_literal: true

# Homebrew formula for clawband — a PreToolUse hook for Claude Code that
# blocks destructive shell commands before they execute.
class Clawband < Formula
  desc "PreToolUse hook for Claude Code that blocks destructive shell commands"
  homepage "https://github.com/jamessoubry/clawband"
  version "2.70.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.70.0/clawband-macos-arm64"
      sha256 "dd1552492e3b4f4923cb7768320e74adb392bbd101a455f662c4e9d8056bb8bc"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.70.0/clawband-macos-x86_64"
      sha256 "0801f7192202dc842b375dd17499102b1924a4174f69bb9c4a68630c5252693f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.70.0/clawband-linux-arm64"
      sha256 "91715c0b553961dd0339a47e49a2ec16230fa715ec7c1079d67ee592aa16ec14"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.70.0/clawband-linux-x86_64"
      sha256 "5a984a41add2b83d24eb1c076c04f6816205acf6d041a73125491b715fc2e292"
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
