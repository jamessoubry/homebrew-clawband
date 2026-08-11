# typed: false
# frozen_string_literal: true

# Homebrew formula for clawband — a PreToolUse hook for Claude Code that
# blocks destructive shell commands before they execute.
class Clawband < Formula
  desc "PreToolUse hook for Claude Code that blocks destructive shell commands"
  homepage "https://github.com/jamessoubry/clawband"
  version "3.5.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v3.5.0/clawband-macos-arm64"
      sha256 "ada16b1a85d7f14cdc0a2bdf9484643fb6726d23750efb31a750370e4ca278d5"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v3.5.0/clawband-macos-x86_64"
      sha256 "dea2869f38ba80b107a3ed389a9f883cfceee1ef55e12c5b6034cfe8acfe542c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v3.5.0/clawband-linux-arm64"
      sha256 "0deac7a617ae85382cd84b01b9af948fd9d1c16a523b2e20e33252aa6a0543ec"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v3.5.0/clawband-linux-x86_64"
      sha256 "8c239ae521979ec50aa56865e38dd755a7afb9a7f84f37b5e7df7877bdc2e1f0"
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
