# typed: false
# frozen_string_literal: true

# Homebrew formula for clawband — a PreToolUse hook for Claude Code that
# blocks destructive shell commands before they execute.
class Clawband < Formula
  desc "PreToolUse hook for Claude Code that blocks destructive shell commands"
  homepage "https://github.com/jamessoubry/clawband"
  version "2.97.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.97.0/clawband-macos-arm64"
      sha256 "928864ebe91c486314fa62f1c4cec14a06a505e3492dbde96731f3f684e306b5"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.97.0/clawband-macos-x86_64"
      sha256 "b5769236ea5e7c1b0941007089355a00c00a1388eee6423b6e6d2266cc75cd37"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.97.0/clawband-linux-arm64"
      sha256 "921988d443ad0d4b2c35f079c7c4f96934ff327425bf88a746011818e5a097c0"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.97.0/clawband-linux-x86_64"
      sha256 "a4eea2a43f57b46b29974855e85a502a54d83f995c3e11845d63cc134419b103"
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
