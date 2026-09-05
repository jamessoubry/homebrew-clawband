# typed: false
# frozen_string_literal: true

# Homebrew formula for clawband — a PreToolUse hook for Claude Code that
# blocks destructive shell commands before they execute.
class Clawband < Formula
  desc "PreToolUse hook for Claude Code that blocks destructive shell commands"
  homepage "https://github.com/jamessoubry/clawband"
  version "3.14.6"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v3.14.6/clawband-macos-arm64"
      sha256 "6d1462bfcc3e2b1de376df84ec30296dabdd170cfe42257db0065c5573cc3f89"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v3.14.6/clawband-macos-x86_64"
      sha256 "1ca7d5ca949daa73e3e090a8e94b5820baa319a26c7cb05aeaf0ec9b56ef1eea"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v3.14.6/clawband-linux-arm64"
      sha256 "d3483c28f61094f4ebef3019d7d36040f55c71ae5ea3e08a88e995de95b5defd"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v3.14.6/clawband-linux-x86_64"
      sha256 "694ff5d58208a811986ae22d74a5058553edb765d384097119ffc872c4205188"
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
