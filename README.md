# homebrew-clawband

Homebrew tap for [clawband](https://github.com/jamessoubry/clawband) — a `PreToolUse` hook for Claude Code that blocks destructive shell commands before they execute.

## Install

```sh
brew install jamessoubry/clawband/clawband
```

Or tap first, then install:

```sh
brew tap jamessoubry/clawband
brew install clawband
```

After installing, wire it into Claude Code (see the [main README](https://github.com/jamessoubry/clawband#installation)) — `brew` installs the binary but does not modify your `~/.claude/settings.json`.

## Upgrade

```sh
brew upgrade clawband
```

The formula here is bumped automatically by the [clawband release workflow](https://github.com/jamessoubry/clawband/blob/master/.github/workflows/release.yml) on every tagged release.
