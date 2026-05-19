# dotfiles

Personal dotfiles for Edward Paget, managed with symlinks via Rake.

## Installation

```bash
rake install
```

This symlinks each top-level file/directory into `$HOME` as a dotfile (e.g., `bashrc` -> `~/.bashrc`). Files like `Rakefile`, `README.md`, and `Brewfile` are excluded.

### User-local install (no admin / no `/opt/homebrew`)

On a machine where you can only install into your home directory, install Homebrew into `$HOME` (e.g. `~/homebrew`) and the shell config will pick it up automatically:

```bash
git clone https://github.com/Homebrew/brew ~/homebrew
# then `rake install` and start a new shell
```

`bash/env` probes `~/homebrew`, `~/.homebrew`, `~/.linuxbrew`, `/opt/homebrew`, the Linuxbrew system path, and `/usr/local/bin/brew` in that order, so the first one that exists wins.

Caveats when running from a user-local Homebrew:
- Most `brew` entries in the `Brewfile` build from source and work fine — `brew bundle` will compile what isn't bottled.
- `cask` entries (`font-iosevka`, `font-iosevka-term-slab-nerd-font`) install into system locations and generally need admin. Install fonts manually into `~/Library/Fonts` (macOS) or `~/.local/share/fonts` (Linux) instead.
- `emacs-plus@29` is a large source build; if Emacs isn't needed on this machine just skip it.

## What's Included

- **bash/** — Shell config split into `aliases`, `config`, `env`, and `prompt`, sourced from `bashrc`
- **config/nvim/** — Neovim config (Lua, lazy.nvim plugin manager)
- **config/workmux/** — workmux session configs with Claude agent integration and rebase merge strategy
- **config/starship.toml** — Starship prompt config
- **doom.d/** — Doom Emacs config
- **clojure/** — Clojure deps.edn
- **tmux.conf** — tmux config (prefix: `C-a`, vim keybindings, tiling master+stack layout, Solarized theme)
- **tmux-git-status.sh** — Script showing git branch/dirty status in the tmux status bar
- **gitconfig** — Git config with aliases
- **Brewfile** — Homebrew dependencies (includes tmux, neovim, workmux)

## License

See [LICENSE](LICENSE).
