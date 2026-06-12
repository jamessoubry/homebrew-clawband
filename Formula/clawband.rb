# typed: false
# frozen_string_literal: true

# Homebrew formula for clawband — a PreToolUse hook for Claude Code that
# blocks destructive shell commands before they execute.
class Clawband < Formula
  desc "PreToolUse hook for Claude Code that blocks destructive shell commands"
  homepage "https://github.com/jamessoubry/clawband"
  version "2.39.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.39.0/clawband-macos-arm64"
      sha256 "d36b21c9e0e8fdbcc7f6c1bea4bafb1b9a61e14ce6adee6c3947f2685a1c0794"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.39.0/clawband-macos-x86_64"
      sha256 "708887172120d251c4bed9a03384cf491411dda1e02d7acc848d6e6e9af10c14"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.39.0/clawband-linux-arm64"
      sha256 "15cb0b8184edb0825a8115b971de0b41c9728875e69f364c4ad936fe819a1722"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.39.0/clawband-linux-x86_64"
      sha256 "e27d22337f001d25195f5250d218828e066741e37c85734154877f10eb2f838c"
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
