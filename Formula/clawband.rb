# typed: false
# frozen_string_literal: true

# Homebrew formula for clawband — a PreToolUse hook for Claude Code that
# blocks destructive shell commands before they execute.
class Clawband < Formula
  desc "PreToolUse hook for Claude Code that blocks destructive shell commands"
  homepage "https://github.com/jamessoubry/clawband"
  version "2.69.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.69.0/clawband-macos-arm64"
      sha256 "a1a4a5fce5e7dab436ea3083c7745a85a1fe9cf1ed8f323cc2df60ff2903e946"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.69.0/clawband-macos-x86_64"
      sha256 "acbb87848c4807e88c703dcdda79a3d3b98f465fc10101bc3572b53b529222d2"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.69.0/clawband-linux-arm64"
      sha256 "209db346cbb6fce210d2b4e988e514e14d9904038889bc535d02a213e05032bd"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.69.0/clawband-linux-x86_64"
      sha256 "d077db30bac6b6c0e5ae63352527a56371e80cf5f91f153a97ad0277dbb941e5"
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
