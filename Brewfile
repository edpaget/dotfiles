# Global tools — always-on system CLIs.
# Project-scoped toolchains (node, rust, language servers, etc.) live in
# config/mise/config.toml so they can be overridden per-project.
#
# ONE BREWFILE, TWO PLATFORMS. This file is Ruby, so entries that only make
# sense on one OS are guarded rather than split into a second file. Three
# categories are macOS-only:
#
#   * GNU replacements (bash, coreutils, grep) — macOS ships ancient bash and
#     BSD userland, so brew's copies are the point. Linux already IS GNU, and
#     newer: installing brew's would put a second, older copy ahead of the
#     system one on PATH for no gain.
#   * Casks — Homebrew Cask does not work on any Linux distribution. On Linux
#     the fonts come from the distro instead (Arch: `ttf-iosevka-nerd`,
#     installed by ansible in roles/desktop on `oedipus`).
#   * ollama — the Linux box wants GPU acceleration, which means the distro's
#     CUDA-enabled build (Arch: `ollama-cuda`, installed by ansible), not a
#     CPU-only brew bottle.
#
# Everything unguarded below is genuinely wanted on both, and that is the
# point of keeping one file: `brew bundle` behaves the same everywhere.

tap "raine/workmux"
tap "edpaget/rdm"

# Shell & core utilities
brew "bash" if OS.mac?
brew "coreutils" if OS.mac?
brew "grep" if OS.mac?
brew "git"
brew "mise"
brew "starship"

# Terminal multiplexer & editor
brew "tmux"
brew "neovim"

# Search & data tooling
brew "ripgrep"
brew "fd"
brew "jq"

# Local LLM runtime. On Linux, ollama comes from the distro with CUDA support
# (see the header) — a CPU-only ollama on a machine with an RTX 3070 Ti in it
# would be a waste of the hardware.
brew "ollama" if OS.mac?
brew "pi-coding-agent"

# LLVM toolchain (headers + llvm-config for inkwell/llvm-sys-backed compiler work).
# Pinned to a major because llvm-sys requires an exact LLVM major match.
brew "llvm@22"

# Personal tools
brew "raine/workmux/workmux"
brew "edpaget/rdm/rdm-cli"

# Fonts (cask — macOS only; Cask does not work on Linux at all. Needs admin;
# skip on user-local installs and drop fonts into ~/Library/Fonts manually.)
cask "font-iosevka" if OS.mac?
cask "font-iosevka-term-slab-nerd-font" if OS.mac?
