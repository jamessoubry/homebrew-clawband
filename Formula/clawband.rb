# typed: false
# frozen_string_literal: true

# Homebrew formula for clawband — a PreToolUse hook for Claude Code that
# blocks destructive shell commands before they execute.
class Clawband < Formula
  desc "PreToolUse hook for Claude Code that blocks destructive shell commands"
  homepage "https://github.com/jamessoubry/clawband"
  version "3.7.12"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v3.7.12/clawband-macos-arm64"
      sha256 "46c84b6aa8eb016d332ef763e4333ff2962e9789a0ce8defcdabba0c39d20024"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v3.7.12/clawband-macos-x86_64"
      sha256 "20c4460e73f85821ea8fb99a253f34e64eee71e6c8d237ef21513cd1754d1d35"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v3.7.12/clawband-linux-arm64"
      sha256 "2bb163453e6abfbce17420dd9da5938c0d57403a4f934bc895b5065c6786d71f"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v3.7.12/clawband-linux-x86_64"
      sha256 "1d1177a3873d217e97915e3fa50bd8dc0d37944db3a667bbd2177a205a78cea2"
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
