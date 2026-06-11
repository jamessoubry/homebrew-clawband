# typed: false
# frozen_string_literal: true

# Homebrew formula for clawband — a PreToolUse hook for Claude Code that
# blocks destructive shell commands before they execute.
class Clawband < Formula
  desc "PreToolUse hook for Claude Code that blocks destructive shell commands"
  homepage "https://github.com/jamessoubry/clawband"
  version "2.29.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.29.0/clawband-macos-arm64"
      sha256 "a9d37a305cbc5360eba80d8e169afa839dacce98450d4e2f09a2b4c619592fb5"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.29.0/clawband-macos-x86_64"
      sha256 "c3b94a55384c8c8142e26662bb9f4f37ac45fd90239b6934dfa685f55172d709"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.29.0/clawband-linux-arm64"
      sha256 "afcef63be52186f4f05b9f6c1005079144f2013e9a3d6e64aaf738ea7f8606a1"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.29.0/clawband-linux-x86_64"
      sha256 "1cafef502e06984c9bc8804e527c3d52c4991b316c4db140a13b81207cf68f7f"
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
