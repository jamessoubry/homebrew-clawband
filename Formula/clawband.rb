# typed: false
# frozen_string_literal: true

# Homebrew formula for clawband — a PreToolUse hook for Claude Code that
# blocks destructive shell commands before they execute.
class Clawband < Formula
  desc "PreToolUse hook for Claude Code that blocks destructive shell commands"
  homepage "https://github.com/jamessoubry/clawband"
  version "3.7.9"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v3.7.9/clawband-macos-arm64"
      sha256 "a00ff92de1aa59d0a02649179028eb1771380d4f8693ea6b6b876bd518540c3f"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v3.7.9/clawband-macos-x86_64"
      sha256 "92d3006d290f771239c0acf924c8dc68050cd2be5679d1c7b30874abf158fc03"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v3.7.9/clawband-linux-arm64"
      sha256 "d9351c9a32c6d776c93be7a9138b5ffa548057f492fb65f64c359df8ef078361"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v3.7.9/clawband-linux-x86_64"
      sha256 "39d610a192f21a8a1ec39dc5bfb89dd4eaf2114994ad2add6a47b13e7e156add"
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
