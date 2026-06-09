# typed: false
# frozen_string_literal: true

# Homebrew formula for clawband — a PreToolUse hook for Claude Code that
# blocks destructive shell commands before they execute.
class Clawband < Formula
  desc "PreToolUse hook for Claude Code that blocks destructive shell commands"
  homepage "https://github.com/jamessoubry/clawband"
  version "2.21.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.21.0/clawband-macos-arm64"
      sha256 "5b84817ca64d2fdbc36b31013768735c60de1bd771d34c3a460939f60e613b9f"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.21.0/clawband-macos-x86_64"
      sha256 "8e2d8ad10f77f1231e3f7d08b5cd1743695d2d7fdacfd12a4e71461041329264"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.21.0/clawband-linux-x86_64"
      sha256 "49ae32d833f0e4add23ee4e438c7a4709b821ff57c93b17b48e09beea91a52d3"
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
