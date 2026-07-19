# typed: false
# frozen_string_literal: true

# Homebrew formula for clawband — a PreToolUse hook for Claude Code that
# blocks destructive shell commands before they execute.
class Clawband < Formula
  desc "PreToolUse hook for Claude Code that blocks destructive shell commands"
  homepage "https://github.com/jamessoubry/clawband"
  version "3.0.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v3.0.0/clawband-macos-arm64"
      sha256 "c6c03610204b1a853d31cba61f2ea2703e14e50274bcd780e801c2365b0d5abe"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v3.0.0/clawband-macos-x86_64"
      sha256 "95c3d15d997b696dfce1ab37d05cd721762c7c2af96f7badfc5e8fba39a48e4f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v3.0.0/clawband-linux-arm64"
      sha256 "d78406285f8e3ca8aa9292ef887e24a7e9ba4d7f0f2a721dd4a0fca21be1a1b8"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v3.0.0/clawband-linux-x86_64"
      sha256 "8720e68decbaaf875d85dbc13d98ed7a6ea304aa710c6a92be291f42ff35f7e7"
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
