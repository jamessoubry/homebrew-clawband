# typed: false
# frozen_string_literal: true

# Homebrew formula for clawband — a PreToolUse hook for Claude Code that
# blocks destructive shell commands before they execute.
class Clawband < Formula
  desc "PreToolUse hook for Claude Code that blocks destructive shell commands"
  homepage "https://github.com/jamessoubry/clawband"
  version "3.7.13"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v3.7.13/clawband-macos-arm64"
      sha256 "12a680bc3d567a8cad2c7db73c146c5b3f5447a20ebe37cb88c9ffd87ded5c18"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v3.7.13/clawband-macos-x86_64"
      sha256 "49a1a8aa54f80ae6402bae0ac0eb83fb43856f6121279f0e13177e5e3595ddd7"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v3.7.13/clawband-linux-arm64"
      sha256 "3cb8ba05e8d4c6307eda6b043f70b41a9d85a02aab3218f07a60187a7c3f072c"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v3.7.13/clawband-linux-x86_64"
      sha256 "6fe91a155e7e2aac69d48332da9e9f90a0a1a26d5dcb4e529a75a2996758b9e1"
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
