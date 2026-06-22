# typed: false
# frozen_string_literal: true

# Homebrew formula for clawband — a PreToolUse hook for Claude Code that
# blocks destructive shell commands before they execute.
class Clawband < Formula
  desc "PreToolUse hook for Claude Code that blocks destructive shell commands"
  homepage "https://github.com/jamessoubry/clawband"
  version "2.93.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.93.0/clawband-macos-arm64"
      sha256 "dee00af13a5bd9d1ce239419e28cbebcc7a5e9dd260054d48f83a6c92fc2c84e"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.93.0/clawband-macos-x86_64"
      sha256 "6c129059cf69517a224d5dd0571f43481a3a9eddcfca13acd4e4a851718767e5"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.93.0/clawband-linux-arm64"
      sha256 "7ce7047504d357167e9b90bdb7f7b68baed52865eb8698f1840f53c191f4018c"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.93.0/clawband-linux-x86_64"
      sha256 "e3f769979ccda1eeb550e71c143e82e881e578a311a535f3e3805583d18ec5f0"
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
