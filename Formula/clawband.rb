# typed: false
# frozen_string_literal: true

# Homebrew formula for clawband — a PreToolUse hook for Claude Code that
# blocks destructive shell commands before they execute.
class Clawband < Formula
  desc "PreToolUse hook for Claude Code that blocks destructive shell commands"
  homepage "https://github.com/jamessoubry/clawband"
  version "2.62.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.62.0/clawband-macos-arm64"
      sha256 "78db85e1f18da247f79dd84d49d578e4d11924f1256265bf2cba23410d56dd08"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.62.0/clawband-macos-x86_64"
      sha256 "fd3c6eb3407183cbaf23943f1ffc1369847a95a6d52806403b02fdf0e0d7b37f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.62.0/clawband-linux-arm64"
      sha256 "b0a62ab3ab38c12150b417e9ffa274e6715c7da2283a4cfe510573c040ede23f"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v2.62.0/clawband-linux-x86_64"
      sha256 "44560928aee29bc018112d3f8d64cdbc9ba1cf5822a5a89614d322fea4775096"
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
