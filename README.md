Install nvim

Setup keys

```bash
ssh-keygen -t ed25519 -C "your_email@example.com"
```

Copy the output to a new github SSH file

```bash
cat ~/.ssh/id_ed25519.pub
```

Install the latest nvim

```bash
curl -sL $(curl -s https://api.github.com/repos/neovim/neovim/releases/latest | grep "browser_download_url.*nvim-linux64.tar.gz" | cut -d '"' -f 4) -o nvim.tar.gz && tar xzf nvim.tar.gz && sudo cp -r nvim-linux64/bin/* /usr/local/bin/ && sudo cp -r nvim-linux64/share/* /usr/local/share/ && if [ -d "/usr/local/man" ] || [ -L "/usr/local/man" ]; then sudo cp -r nvim-linux64/man/* /usr/local/man/; else sudo cp -r nvim-linux64/man /usr/local/; fi && rm -rf nvim.tar.gz nvim-linux64
```

Clone this repo

```bash
mkdir -p ~/.config
git clone git@github.com:ryardley/nvimsettings.git ~/.config/nvim
```
