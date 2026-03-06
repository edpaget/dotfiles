# Dotfiles

Personal dotfiles for Edward Paget, managed with symlinks via Rake.

## Structure

- `Rakefile` — Installation script. `rake install` symlinks each top-level file/directory into `$HOME` as a dotfile (e.g., `bashrc` → `~/.bashrc`). Files named `Rakefile`, `README.md`, and `Brewfile` are excluded from linking.
- `bash/` — Shell config split into `aliases`, `config`, `env`, and `prompt`, sourced from `bashrc`
- `config/nvim/` — Neovim config (Lua, lazy.nvim plugin manager)
- `config/workmux/` — workmux session config (uses claude agent, rebase merge strategy)
- `config/starship.toml` — Starship prompt config
- `doom.d/` — Doom Emacs config
- `clojure/` — Clojure deps.edn
- `tmux.conf` — tmux config (prefix: Ctrl-a, vim keybindings, Solarized theme)
- `tmux-git-status.sh` — Script showing git branch/dirty status in tmux status bar
- `gitconfig` — Git config with aliases
- `Brewfile` — Homebrew dependencies

## Conventions

- Top-level files and directories get symlinked as dotfiles to `$HOME`. Don't add top-level files unless they should become dotfiles.
- Neovim uses 2-space indentation, spaces not tabs.
- The git default branch is `main`.
- tmux prefix is `C-a`, not `C-b`.
