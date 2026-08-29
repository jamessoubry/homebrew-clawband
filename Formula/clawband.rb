# typed: false
# frozen_string_literal: true

# Homebrew formula for clawband — a PreToolUse hook for Claude Code that
# blocks destructive shell commands before they execute.
class Clawband < Formula
  desc "PreToolUse hook for Claude Code that blocks destructive shell commands"
  homepage "https://github.com/jamessoubry/clawband"
  version "3.7.14"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v3.7.14/clawband-macos-arm64"
      sha256 "acf6593afd45fda3a659db077f44206e94f19f4b51ec05540d8e553b6a9667ca"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v3.7.14/clawband-macos-x86_64"
      sha256 "5b889ab2cfa5a87f07d1e93e408b0905748327acccc30e2a1e0a696484839165"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v3.7.14/clawband-linux-arm64"
      sha256 "217968998ae281ebb2c33512b2264cefd8d17f6c8c2120f866440caa087f9b00"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v3.7.14/clawband-linux-x86_64"
      sha256 "478389493245de8bf7a9d6d159d23f66d33b67a2e7e9a2f903ee686f30e81bc9"
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
