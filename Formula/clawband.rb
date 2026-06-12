# typed: false
# frozen_string_literal: true

# Homebrew formula for clawband — a PreToolUse hook for Claude Code that
# blocks destructive shell commands before they execute.
class Clawband < Formula
  desc "PreToolUse hook for Claude Code that blocks destructive shell commands"
  homepage "https://github.com/jamessoubry/clawband"
  version "2.35.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.35.0/clawband-macos-arm64"
      sha256 "5c730a9f4c6a247f2853f55874480c7b0171d4c67a5ba16aa075a0dc9ff64560"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.35.0/clawband-macos-x86_64"
      sha256 "f702b3689099cb6e212effb5a19b72d06270234c2d6e3ecb5e01cec7e9175c48"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.35.0/clawband-linux-arm64"
      sha256 "2146f103f9540cc49b8b8aa39a22067e9559d2ba95433350b495bc09cba9cb2e"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.35.0/clawband-linux-x86_64"
      sha256 "6394fef795f57ffd495987bbcbcf1b83c205ceb95f68e0423163fcec4f47434c"
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
