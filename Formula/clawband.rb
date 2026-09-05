# typed: false
# frozen_string_literal: true

# Homebrew formula for clawband — a PreToolUse hook for Claude Code that
# blocks destructive shell commands before they execute.
class Clawband < Formula
  desc "PreToolUse hook for Claude Code that blocks destructive shell commands"
  homepage "https://github.com/jamessoubry/clawband"
  version "3.14.3"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v3.14.3/clawband-macos-arm64"
      sha256 "d28df228f085e2a0b109f4ec856905c804e778ebbacf9b00827f11fe4b302a81"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v3.14.3/clawband-macos-x86_64"
      sha256 "bf1833b6f29d56b2a0fbcb839cd370350da645b294941145d5d15a9c41b4f719"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v3.14.3/clawband-linux-arm64"
      sha256 "a6948c0de80dcc92c8bef37f121d0e3f3eea7f0d46e2318e1209f2cd74768650"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v3.14.3/clawband-linux-x86_64"
      sha256 "7d7e65278b6495ac5d10159f3c207861480f4a8c6eeda96b70559ad468fb02b3"
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
