# Global tools — always-on system CLIs.
# Project-scoped toolchains (node, rust, language servers, etc.) live in
# config/mise/config.toml so they can be overridden per-project.

tap "raine/workmux"
tap "edpaget/rdm"

# Shell & core utilities
brew "bash"
brew "coreutils"
brew "grep"
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

# Local LLM runtime
brew "ollama"

# LLVM toolchain (headers + llvm-config for inkwell/llvm-sys-backed compiler work).
# Pinned to a major because llvm-sys requires an exact LLVM major match.
brew "llvm@22"

# Personal tools
brew "raine/workmux/workmux"
brew "edpaget/rdm/rdm-cli"

# Fonts (cask — needs admin; skip on user-local installs and drop fonts into ~/Library/Fonts manually)
cask "font-iosevka"
cask "font-iosevka-term-slab-nerd-font"
