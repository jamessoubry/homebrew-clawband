# typed: false
# frozen_string_literal: true

# Homebrew formula for clawband — a PreToolUse hook for Claude Code that
# blocks destructive shell commands before they execute.
class Clawband < Formula
  desc "PreToolUse hook for Claude Code that blocks destructive shell commands"
  homepage "https://github.com/jamessoubry/clawband"
  version "3.7.10"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v3.7.10/clawband-macos-arm64"
      sha256 "f86ac23b9476a356c64bcc8f84f744dfd911b080d4b31e82516f3a62c47d3259"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v3.7.10/clawband-macos-x86_64"
      sha256 "12a27150d658bc117d4d9d407f37941cb3040727bebc17d9d3985c18ce2bf848"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v3.7.10/clawband-linux-arm64"
      sha256 "fb17b95a68844bad28e9faee1564f80cbcc6781096de704ef6dab6509a10daeb"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v3.7.10/clawband-linux-x86_64"
      sha256 "6c9344e23866a4ce1dfdf7296174d3b10170e272c91ce17bf1ccf67ec9c3f041"
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
