# typed: false
# frozen_string_literal: true

# Homebrew formula for clawband — a PreToolUse hook for Claude Code that
# blocks destructive shell commands before they execute.
class Clawband < Formula
  desc "PreToolUse hook for Claude Code that blocks destructive shell commands"
  homepage "https://github.com/jamessoubry/clawband"
  version "2.31.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.31.0/clawband-macos-arm64"
      sha256 "7765405881119624f4aae2de05a7914478ee77101346bc88eabfeb0159306ed6"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.31.0/clawband-macos-x86_64"
      sha256 "03af35b7709f73e1c521b1266b959fb138e149d6f1399ad08b9157d173fae538"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.31.0/clawband-linux-arm64"
      sha256 "9a6c44f94c33653c69092b6666e2c0c346a84766ca9c1d8fa14d0cdb0a0a885d"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.31.0/clawband-linux-x86_64"
      sha256 "3b8816b19394fa2044927d176883e894ca4c47d0f3f49f584af7598083da4df9"
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
