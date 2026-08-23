# typed: false
# frozen_string_literal: true

# Homebrew formula for clawband — a PreToolUse hook for Claude Code that
# blocks destructive shell commands before they execute.
class Clawband < Formula
  desc "PreToolUse hook for Claude Code that blocks destructive shell commands"
  homepage "https://github.com/jamessoubry/clawband"
  version "3.7.8"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v3.7.8/clawband-macos-arm64"
      sha256 "e82aff17e08580c5e584d3bde15e9686c5666f08a6938df23191e548142386ac"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v3.7.8/clawband-macos-x86_64"
      sha256 "f74d3fb99e42f5a005a81b08f8dc285d1a59f068f0c0cf84eb85d8df95042375"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v3.7.8/clawband-linux-arm64"
      sha256 "62910f6dbb515b7b05b5894114941e24b49765ab0e91d24e87267521bee217df"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v3.7.8/clawband-linux-x86_64"
      sha256 "c0afccf648ae06468634079eb848a2190256efdfe9da22df13b8a19f2199a20f"
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
