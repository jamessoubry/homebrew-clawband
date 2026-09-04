# typed: false
# frozen_string_literal: true

# Homebrew formula for clawband — a PreToolUse hook for Claude Code that
# blocks destructive shell commands before they execute.
class Clawband < Formula
  desc "PreToolUse hook for Claude Code that blocks destructive shell commands"
  homepage "https://github.com/jamessoubry/clawband"
  version "3.13.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v3.13.0/clawband-macos-arm64"
      sha256 "89fa304299efd7dbfb46eaf962625634edc60bf8b365e1ea36c22d5f9815458b"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v3.13.0/clawband-macos-x86_64"
      sha256 "4808f48d3fd841352d6f8d220722330b5f026ff75597bfa21d94feac0f676cfc"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v3.13.0/clawband-linux-arm64"
      sha256 "7554c9939b29935b4ed8f192b60ebd8508553e5f0e4cb3d12e0f0d3e5231a67e"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v3.13.0/clawband-linux-x86_64"
      sha256 "b2c04e3b22f92c0aa62d00c87e972ec682cda14b6e4b9ce3844e16936947c8fc"
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
