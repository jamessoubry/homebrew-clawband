# typed: false
# frozen_string_literal: true

# Homebrew formula for clawband — a PreToolUse hook for Claude Code that
# blocks destructive shell commands before they execute.
class Clawband < Formula
  desc "PreToolUse hook for Claude Code that blocks destructive shell commands"
  homepage "https://github.com/jamessoubry/clawband"
  version "2.96.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.96.0/clawband-macos-arm64"
      sha256 "2786928655b2d1411d7061e8435cc0f154d022d972000f34389ceec6b0fe8db6"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.96.0/clawband-macos-x86_64"
      sha256 "498dbe8325dd013390a1d06510d0e22a5e9ba1b681db2eeefc2fcacc1c8366f8"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.96.0/clawband-linux-arm64"
      sha256 "b85cc21327b0af264e6a922d7ef4da28f7ce28f17bc61e0a88f01f26d16675e0"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.96.0/clawband-linux-x86_64"
      sha256 "50bace89a16a3a2bca00c33b98618b32bc4e9f1a0e697bc8543b15206d67a22b"
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
