# typed: false
# frozen_string_literal: true

# Homebrew formula for clawband — a PreToolUse hook for Claude Code that
# blocks destructive shell commands before they execute.
class Clawband < Formula
  desc "PreToolUse hook for Claude Code that blocks destructive shell commands"
  homepage "https://github.com/jamessoubry/clawband"
  version "2.33.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.33.0/clawband-macos-arm64"
      sha256 "286d71b7df5f3e9d2d6e34b446733f1a2d7f5736425e125d7c94858b804887e2"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.33.0/clawband-macos-x86_64"
      sha256 "0dd3036759ec8b604d299deb9cc04e5167b4061b2626cf5e97460c84f2766328"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.33.0/clawband-linux-arm64"
      sha256 "11205e654796066339f371f08819aeaf3b225a8728b0e721ec390eab2ae60776"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.33.0/clawband-linux-x86_64"
      sha256 "aa89c6cae441db945b240822b283e75743ff07d41ce8a74dd5d6177eaf220a1d"
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
