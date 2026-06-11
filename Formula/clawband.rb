# typed: false
# frozen_string_literal: true

# Homebrew formula for clawband — a PreToolUse hook for Claude Code that
# blocks destructive shell commands before they execute.
class Clawband < Formula
  desc "PreToolUse hook for Claude Code that blocks destructive shell commands"
  homepage "https://github.com/jamessoubry/clawband"
  version "2.30.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.30.0/clawband-macos-arm64"
      sha256 "194382cd6bb7491121fa99b03f8a7e8864adeee063a83dc550140edec565cb2a"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.30.0/clawband-macos-x86_64"
      sha256 "d8a6ad89c2a69754e1da4f778af9078be07e491f35bc6a899bb01ebeb005aefe"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.30.0/clawband-linux-arm64"
      sha256 "ace6ee0784b56e6c50067a1c2dd14dcd29e02faf97b079af2763160513ca70ce"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.30.0/clawband-linux-x86_64"
      sha256 "e6bfe77ae54837784aac37110ae20879570948d41ad1a74215b43cd2825e072d"
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
