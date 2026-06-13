# typed: false
# frozen_string_literal: true

# Homebrew formula for clawband — a PreToolUse hook for Claude Code that
# blocks destructive shell commands before they execute.
class Clawband < Formula
  desc "PreToolUse hook for Claude Code that blocks destructive shell commands"
  homepage "https://github.com/jamessoubry/clawband"
  version "2.43.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.43.0/clawband-macos-arm64"
      sha256 "adbb0713e95d820c0e0cc46bb00c9a51639d91474739abfa5800efbd74120cdb"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.43.0/clawband-macos-x86_64"
      sha256 "46066730b007793902068b1ab8261695af67c9141a881c029c9a7c443a51fe47"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.43.0/clawband-linux-arm64"
      sha256 "4c5f113612787312a93e3077e01cf09bf62ffac51f293cfbee198ae624ae2290"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.43.0/clawband-linux-x86_64"
      sha256 "0ba7ddb76ed6c7ab5308c7ebad3252aaf92af8576c4b2f95a076404770a355d8"
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
