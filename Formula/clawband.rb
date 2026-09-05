# typed: false
# frozen_string_literal: true

# Homebrew formula for clawband — a PreToolUse hook for Claude Code that
# blocks destructive shell commands before they execute.
class Clawband < Formula
  desc "PreToolUse hook for Claude Code that blocks destructive shell commands"
  homepage "https://github.com/jamessoubry/clawband"
  version "3.14.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v3.14.2/clawband-macos-arm64"
      sha256 "05727538f7952518c35bc36af9b0c8c8ae6b7cbc44d3ce261a1a0a206351e7a1"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v3.14.2/clawband-macos-x86_64"
      sha256 "c48a62715607a44dcf99fbfb639722a0b2715c773a195a27a72cdf7d76fd0090"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v3.14.2/clawband-linux-arm64"
      sha256 "08269441af936c1cb6682b572809fbd159f98b4a6864bae155f9f159779f1ee4"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v3.14.2/clawband-linux-x86_64"
      sha256 "8f78cec2de4389d8143b36e089b4dd657770dc2f8d96db339904eb4a578fe309"
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
