# dotfiles

Personal dotfiles for Edward Paget, managed with symlinks via Rake.

## Installation

```bash
rake install
```

This symlinks each top-level file/directory into `$HOME` as a dotfile (e.g., `bashrc` -> `~/.bashrc`). Files like `Rakefile`, `README.md`, and `Brewfile` are excluded.

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
