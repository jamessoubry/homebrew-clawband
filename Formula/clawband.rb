# typed: false
# frozen_string_literal: true

# Homebrew formula for clawband — a PreToolUse hook for Claude Code that
# blocks destructive shell commands before they execute.
class Clawband < Formula
  desc "PreToolUse hook for Claude Code that blocks destructive shell commands"
  homepage "https://github.com/jamessoubry/clawband"
  version "2.17.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.17.0/clawband-macos-arm64"
      sha256 "f3296ccf3dc74843525f8b8479775fda2e65e814a6d3a44881480a5445a53e72"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.17.0/clawband-macos-x86_64"
      sha256 "abac8ab6fbeee14f7b38c61aaad7c42e8b96a43aa9e3fd2e92199c74e8721cce"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.17.0/clawband-linux-x86_64"
      sha256 "bf8bbe9e80d45edbb1288335396de1030d8106ced82bf0472dc29d2b45b14205"
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
