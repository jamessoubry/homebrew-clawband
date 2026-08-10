# typed: false
# frozen_string_literal: true

# Homebrew formula for clawband — a PreToolUse hook for Claude Code that
# blocks destructive shell commands before they execute.
class Clawband < Formula
  desc "PreToolUse hook for Claude Code that blocks destructive shell commands"
  homepage "https://github.com/jamessoubry/clawband"
  version "3.4.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v3.4.0/clawband-macos-arm64"
      sha256 "2d7ea8f233cba318cb9cb8ba181a129123e5789dc93a27fe3fafbf335e9c4bd2"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v3.4.0/clawband-macos-x86_64"
      sha256 "9858094df295ca8b69a0e939571ae50d305a045407d2cdbb7b407c52c383ce12"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v3.4.0/clawband-linux-arm64"
      sha256 "4ad1a25f7531c869f03923a59f21dc8c224945cc21dff359387cf4eae66368d2"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v3.4.0/clawband-linux-x86_64"
      sha256 "0edf1cdcf1ec79e39ac6b1dfbd667deea2548e57d0882973ca3912d225e3f38a"
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
