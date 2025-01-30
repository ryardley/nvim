# Neovim config

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

## Clone this repo

```bash
mkdir -p ~/.config
git clone https://github.com/ryardley/nvim.git ~/.config/nvim
```
