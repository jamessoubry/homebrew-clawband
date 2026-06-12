# typed: false
# frozen_string_literal: true

# Homebrew formula for clawband — a PreToolUse hook for Claude Code that
# blocks destructive shell commands before they execute.
class Clawband < Formula
  desc "PreToolUse hook for Claude Code that blocks destructive shell commands"
  homepage "https://github.com/jamessoubry/clawband"
  version "2.36.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.36.0/clawband-macos-arm64"
      sha256 "23b04b555e3e8aa047037931eeb3a97de059f95cb718747f98c0fb018d11a3cb"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.36.0/clawband-macos-x86_64"
      sha256 "022e45b05fce83ad525664f89e10ab42cb687320a7ab3981ccd7c0348ae50655"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.36.0/clawband-linux-arm64"
      sha256 "d2325e5c47744181394f7c09edbe633550c690c69f9267ea057017b264249cfb"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.36.0/clawband-linux-x86_64"
      sha256 "08f629da000322171712937c51119b4aa597c7ec9dada02156098103f531ba7d"
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
