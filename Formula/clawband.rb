# typed: false
# frozen_string_literal: true

# Homebrew formula for clawband — a PreToolUse hook for Claude Code that
# blocks destructive shell commands before they execute.
class Clawband < Formula
  desc "PreToolUse hook for Claude Code that blocks destructive shell commands"
  homepage "https://github.com/jamessoubry/clawband"
  version "3.14.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v3.14.1/clawband-macos-arm64"
      sha256 "3afa29ef5861ef69db44b22b65fdde71c86fe6ffbcd30abac8307ceef0f83527"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v3.14.1/clawband-macos-x86_64"
      sha256 "4fb8f4f2d314b635582751ee60eebe3ac2107a6d785a7a62370bf7bbaacf674a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jamessoubry/clawband/releases/download/v3.14.1/clawband-linux-arm64"
      sha256 "52a65d6e3d2591e6581060b8cd3b793b2bc85d94d7ec0bb4488275e5ef201af2"
    end
    on_intel do
      url "https://github.com/jamessoubry/clawband/releases/download/v3.14.1/clawband-linux-x86_64"
      sha256 "3134d11f1cbbb370ede62531ec2256bc3277a12c90236f46a43b7e21a97aad52"
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
