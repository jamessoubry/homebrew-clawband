# typed: false
# frozen_string_literal: true

# Homebrew formula for clawband — a PreToolUse hook for Claude Code that
# blocks destructive shell commands before they execute.
class Clawband < Formula
  desc "PreToolUse hook for Claude Code that blocks destructive shell commands"
  homepage "https://github.com/jamessoubry/clawband"
  version "3.14.4"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v3.14.4/clawband-macos-arm64"
      sha256 "d646f64e7da121d8f69e0155abcfbd90ffaf10c03828c438f504552f9e31a40d"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v3.14.4/clawband-macos-x86_64"
      sha256 "b1289ba57fa68712e789f1134920f86aa22aa385074d5624c620acb019e6ee2f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v3.14.4/clawband-linux-arm64"
      sha256 "e1845b622d71c143892b39458e9b199d492c78b7d73d43c13a3d5462e471c233"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v3.14.4/clawband-linux-x86_64"
      sha256 "e8963ac92552fc952d53780207055bf5ce2095fac064b5a9ec15e37930e4abcd"
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
