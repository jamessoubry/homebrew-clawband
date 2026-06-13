# typed: false
# frozen_string_literal: true

# Homebrew formula for clawband — a PreToolUse hook for Claude Code that
# blocks destructive shell commands before they execute.
class Clawband < Formula
  desc "PreToolUse hook for Claude Code that blocks destructive shell commands"
  homepage "https://github.com/jamessoubry/clawband"
  version "2.51.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.51.0/clawband-macos-arm64"
      sha256 "c1d27f65919110ddd25f314bd3056a5f1cc1b64584869d65efbf2defefe5b218"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.51.0/clawband-macos-x86_64"
      sha256 "0f315e516d68a332e758305beca784f77675dd2e64bc7b5d78a4ea628d75ef1a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.51.0/clawband-linux-arm64"
      sha256 "b5feeda58fa3a13eab36ef8133e79ba3b81df447c876bd97b59c3e4bea0c33fe"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.51.0/clawband-linux-x86_64"
      sha256 "aff400882a0db92cbbafd674a37dc1d032052ba73605fe623ceba89df03466e4"
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
