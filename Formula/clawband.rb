# typed: false
# frozen_string_literal: true

# Homebrew formula for clawband — a PreToolUse hook for Claude Code that
# blocks destructive shell commands before they execute.
class Clawband < Formula
  desc "PreToolUse hook for Claude Code that blocks destructive shell commands"
  homepage "https://github.com/jamessoubry/clawband"
  version "3.7.15"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v3.7.15/clawband-macos-arm64"
      sha256 "edc4f493f5a0f7824e24e43318060d5c746f5b7ea080fafe60a27d389b9a1fcc"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v3.7.15/clawband-macos-x86_64"
      sha256 "c1926114127d84efea07ced2b40bb678fa84e17e0067e8e987c57a39b2669a74"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v3.7.15/clawband-linux-arm64"
      sha256 "9f616efb6460f1eca8eae6d07142579812e8c605421cea32c544cd039ea092c3"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v3.7.15/clawband-linux-x86_64"
      sha256 "4e81ff0c6a801a65958dca28c3484895734ba0b7977f116123f654400881a702"
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
