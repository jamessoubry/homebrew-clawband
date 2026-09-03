# typed: false
# frozen_string_literal: true

# Homebrew formula for clawband — a PreToolUse hook for Claude Code that
# blocks destructive shell commands before they execute.
class Clawband < Formula
  desc "PreToolUse hook for Claude Code that blocks destructive shell commands"
  homepage "https://github.com/jamessoubry/clawband"
  version "3.11.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v3.11.0/clawband-macos-arm64"
      sha256 "c22f149d1c6351b3c5d7387a77c8651fc04a97470a799d4c8023a38e1e458e0f"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v3.11.0/clawband-macos-x86_64"
      sha256 "74dc310c4ef49f71757a90e3dd6031b3d580f57f4ab4657fcd72ab88d707529b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v3.11.0/clawband-linux-arm64"
      sha256 "f3e96280d5a12bed40b40db733768456afc8e1578477e6b2f489d28b3144f378"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v3.11.0/clawband-linux-x86_64"
      sha256 "e02c80c60745ef60226bd95b28a03da05ad6611e902d6100d5d8537cb3386e5b"
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
