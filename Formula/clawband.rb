# typed: false
# frozen_string_literal: true

# Homebrew formula for clawband — a PreToolUse hook for Claude Code that
# blocks destructive shell commands before they execute.
class Clawband < Formula
  desc "PreToolUse hook for Claude Code that blocks destructive shell commands"
  homepage "https://github.com/jamessoubry/clawband"
  version "2.66.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.66.0/clawband-macos-arm64"
      sha256 "1addb751c5933dcadf35846be6e589e165a34964d2745c5c9735a35fb44b7249"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.66.0/clawband-macos-x86_64"
      sha256 "e95cfb61544f39f74adf4dc92cca5003ed9f6c31a687fd2a2e99eaf586cd455b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.66.0/clawband-linux-arm64"
      sha256 "fa754a2d796f49b3e41311a675b270e5692c2c619fb90b1d00f509930bee9a74"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.66.0/clawband-linux-x86_64"
      sha256 "246ccaa1792731447f58caf08b83bad306a47d25af624e2826b826728a09f1f1"
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
