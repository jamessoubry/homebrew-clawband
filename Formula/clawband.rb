# typed: false
# frozen_string_literal: true

# Homebrew formula for clawband — a PreToolUse hook for Claude Code that
# blocks destructive shell commands before they execute.
class Clawband < Formula
  desc "PreToolUse hook for Claude Code that blocks destructive shell commands"
  homepage "https://github.com/jamessoubry/clawband"
  version "2.60.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.60.0/clawband-macos-arm64"
      sha256 "47c04ddfd7d09a720ba3f1a71c10541ab864d6005d7b34832103774bcb896a1d"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.60.0/clawband-macos-x86_64"
      sha256 "181375c323f1cad11ded56b1af9b1a1e516fe810f9f051afe9a63ffc56f7ecad"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.60.0/clawband-linux-arm64"
      sha256 "bf0e566beb68031fbc07b55c75209268477df70fdc273ea40f35467b78c66d93"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.60.0/clawband-linux-x86_64"
      sha256 "18642d5a41a949c72e8ccba134e58a75bfa2ee3f1c382dc411967c6b43962151"
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
