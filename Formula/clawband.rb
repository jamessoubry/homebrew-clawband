# typed: false
# frozen_string_literal: true

# Homebrew formula for clawband — a PreToolUse hook for Claude Code that
# blocks destructive shell commands before they execute.
class Clawband < Formula
  desc "PreToolUse hook for Claude Code that blocks destructive shell commands"
  homepage "https://github.com/jamessoubry/clawband"
  version "2.32.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.32.0/clawband-macos-arm64"
      sha256 "a7a0698e244520ba66399df681cbac4b0bf6daffddf636345e6432b89c4ccd76"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.32.0/clawband-macos-x86_64"
      sha256 "a2d0811d27b5832263b2ff27eea52fa65c0e8ee54bb46bbba366ed4717b635c1"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.32.0/clawband-linux-arm64"
      sha256 "8ce586ba887549ac040aac476e01b5dd8802f80678dcd3ee39809e56766e35e6"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.32.0/clawband-linux-x86_64"
      sha256 "9cd3d70bf33a93f3b3fe4d3b573a7e635e306cd66746a144cdaadf9c73e2ed38"
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
