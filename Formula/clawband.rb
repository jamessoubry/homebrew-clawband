# typed: false
# frozen_string_literal: true

# Homebrew formula for clawband — a PreToolUse hook for Claude Code that
# blocks destructive shell commands before they execute.
class Clawband < Formula
  desc "PreToolUse hook for Claude Code that blocks destructive shell commands"
  homepage "https://github.com/jamessoubry/clawband"
  version "3.14.5"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v3.14.5/clawband-macos-arm64"
      sha256 "de9cffe993c43382edd0282635fd7fa241ba1afac65f10f6ade6802ab5cb9e1c"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v3.14.5/clawband-macos-x86_64"
      sha256 "61ea3f6a47058e6a4dde48c5453cc24aeb1002111b72dc66a04bfaa6913a86d4"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v3.14.5/clawband-linux-arm64"
      sha256 "e8788b0c9fbb52f34f580c9b2437c2454d8fa8c7af68d7ab83f57da30d72023a"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v3.14.5/clawband-linux-x86_64"
      sha256 "3a63be83c2fcc57166a3e2226fb00cf4c1674ae4df46ff6f24532fe49afcd2ae"
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
