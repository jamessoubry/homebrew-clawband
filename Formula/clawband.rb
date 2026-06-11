# typed: false
# frozen_string_literal: true

# Homebrew formula for clawband — a PreToolUse hook for Claude Code that
# blocks destructive shell commands before they execute.
class Clawband < Formula
  desc "PreToolUse hook for Claude Code that blocks destructive shell commands"
  homepage "https://github.com/jamessoubry/clawband"
  version "2.34.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.34.0/clawband-macos-arm64"
      sha256 "53c850bd9c5d62924d2162c7693dde137dba02abb936e5f67f06c388f7d3e852"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.34.0/clawband-macos-x86_64"
      sha256 "670840b8c3c957be30e343cd73c8b57e58abacfbb19b71b66ebae8f4ac03d1fa"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.34.0/clawband-linux-arm64"
      sha256 "a6916835861cd78c983d7cf7dfcb6eaf5c59421bdfe9f95755ff6308dc7fbbc4"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.34.0/clawband-linux-x86_64"
      sha256 "42baf06866031c9d5c1b2c9f000cdd3aa9af885b86e7f4e2f2147a8689958c1c"
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
