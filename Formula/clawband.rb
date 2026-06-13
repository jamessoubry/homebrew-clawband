# typed: false
# frozen_string_literal: true

# Homebrew formula for clawband — a PreToolUse hook for Claude Code that
# blocks destructive shell commands before they execute.
class Clawband < Formula
  desc "PreToolUse hook for Claude Code that blocks destructive shell commands"
  homepage "https://github.com/jamessoubry/clawband"
  version "2.46.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.46.0/clawband-macos-arm64"
      sha256 "e935974c89ccb99f35f5c85e869705423abf0845d4013847890f6c4a8ac27365"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.46.0/clawband-macos-x86_64"
      sha256 "4ecc8548f3d4bade04781fe36627d237b974b985ee8e8cddba81460ed775f8c4"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.46.0/clawband-linux-arm64"
      sha256 "fc434c476f5293bd0b8be77b3bb252adb27e92fce5390a26e70db02badb2a520"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.46.0/clawband-linux-x86_64"
      sha256 "b5acb63622ff6d4368eb94fa09d10c7b60d7dfb2b89122dbc017f7dbd3da563c"
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
