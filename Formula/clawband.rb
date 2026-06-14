# typed: false
# frozen_string_literal: true

# Homebrew formula for clawband — a PreToolUse hook for Claude Code that
# blocks destructive shell commands before they execute.
class Clawband < Formula
  desc "PreToolUse hook for Claude Code that blocks destructive shell commands"
  homepage "https://github.com/jamessoubry/clawband"
  version "2.61.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.61.0/clawband-macos-arm64"
      sha256 "0a3bf1013e52a46b3fe8e37d8bd1b08def6047ec1c070b613cc1a097d7aa8bec"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.61.0/clawband-macos-x86_64"
      sha256 "5acb80c39ca71834c9d8b693ff3a99d1f68aae1b9ae5041e3fd98cf095a09cb3"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.61.0/clawband-linux-arm64"
      sha256 "b81c2de8a7959c34bf7e5627bda00e5501d8fd1a63c0f5db189e9d0ca29c396f"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.61.0/clawband-linux-x86_64"
      sha256 "730f231cfa4312bc3ef717ad80f2a8eb5afc4719c4d52b961cb4d946021e2ca1"
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
