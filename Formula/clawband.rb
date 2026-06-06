# typed: false
# frozen_string_literal: true

# Homebrew formula for clawband — a PreToolUse hook for Claude Code that
# blocks destructive shell commands before they execute.
class Clawband < Formula
  desc "PreToolUse hook for Claude Code that blocks destructive shell commands"
  homepage "https://github.com/jamessoubry/clawband"
  version "2.13.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.13.0/clawband-macos-arm64"
      sha256 "8544f29664aff25c956b071b1e391a77143d37efa3acf306e1f467787c3f86cb"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.13.0/clawband-macos-x86_64"
      sha256 "2e18b433270d3991f5134c9f6539601576a98a17a43d6622868d1c430b90d01c"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.13.0/clawband-linux-x86_64"
      sha256 "a824fd6854584a14d3eee0aa0c1071bd16edee7b54965e28ecf0dda234b32a75"
    end
  end

  def install
    # The downloaded asset is a bare binary named per-platform; install as "clawband".
    bin.install Dir["clawband-*"].first => "clawband"
  end

  def caveats
    <<~CAVEAT
      clawband is installed, but it is not yet wired into Claude Code.

      Register it as a PreToolUse hook in ~/.claude/settings.json:

        {
          "hooks": {
            "PreToolUse": [
              {
                "matcher": "Bash",
                "hooks": [{"type": "command", "command": "#{opt_bin}/clawband"}]
              }
            ]
          }
        }

      Then run /hooks in Claude Code (or restart) to activate.
      See: https://github.com/jamessoubry/clawband#installation
    CAVEAT
  end

  test do
    assert_match "clawband v#{version}", shell_output("#{bin}/clawband --version")
  end
end
