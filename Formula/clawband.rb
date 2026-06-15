# typed: false
# frozen_string_literal: true

# Homebrew formula for clawband — a PreToolUse hook for Claude Code that
# blocks destructive shell commands before they execute.
class Clawband < Formula
  desc "PreToolUse hook for Claude Code that blocks destructive shell commands"
  homepage "https://github.com/jamessoubry/clawband"
  version "2.67.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.67.0/clawband-macos-arm64"
      sha256 "cd2cb064f06bfc913eb22b033f690fe2046e20f301936d223c0b609c8c73a9a7"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.67.0/clawband-macos-x86_64"
      sha256 "f6a349f3736dd613a7cadc34aa33a4387b12c71dbe680988dc9f6658f4b11dc9"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.67.0/clawband-linux-arm64"
      sha256 "38952e1c96cd2d804141a231271501920fe6a9eb9b09937f29c5454d3bc02859"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.67.0/clawband-linux-x86_64"
      sha256 "b68aab3ae41e232c9b6a2d675a9cbd8327122324d7c4bd3bd072c783cee8c5a4"
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
