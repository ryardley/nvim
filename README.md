# Neovim config

## Requirements

- **Neovim 0.12+** — the config uses `vim.lsp.config`/`vim.lsp.enable` (0.11+) and nvim-treesitter's `main` branch (0.12+). Distro packages are often too old; prefer the [AppImage](https://github.com/neovim/neovim/releases), the Ubuntu PPA, or your package manager's latest.
- `git` (to bootstrap lazy.nvim)
- `ripgrep` (for Telescope)
- A [Nerd Font](https://www.nerdfonts.com/) (for icons)
- `tree-sitter-cli` 0.26.1+ and a C compiler (for nvim-treesitter parser installs)
- Optional: `node`/`npm` (for LSP servers like `typescript-language-server`, `mdx-language-server`), `pnpm` (solidity LSP), a running tmux (for tmux navigation)

> LSPs are expected to be provided by your project environment (direnv, `nix develop`, mise, etc.). They are not auto-installed — servers start when you open a matching file inside a project and are skipped silently when their binary isn't on your `PATH`.

## Install nvim

### Ubuntu, Debian, Linux Mint, Pop!\_OS

```bash
sudo apt install neovim
```

### Fedora, RHEL

```bash
sudo dnf install neovim
```

### Arch Linux, Manjaro

```bash
sudo pacman -S neovim
```

### openSUSE

```bash
sudo zypper install neovim
```

### Alpine

```bash
sudo apk add neovim
```

### NixOS

```bash
# in your configuration.nix
environment.systemPackages = [ pkgs.neovim ];
```

> ⚠️ Ensure the installed Neovim is 0.12+ (see Requirements).

## Clone this repo

```bash
mkdir -p ~/.config
git clone https://github.com/ryardley/nvim.git ~/.config/nvim
```

## First run

Start `nvim` to let lazy.nvim install the plugins, then run:

- `:Lazy sync` — install/update plugins
- `:TSUpdate` — update treesitter parsers
- `:checkhealth` — verify the setup
