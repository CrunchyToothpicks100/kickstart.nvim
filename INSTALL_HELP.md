# Install help

## Git

```bash
sudo apt install git -y
git config --global user.email "your_email@example.com"
git config --global user.name "your_name"
```

## Latest Neovim (from curl)

```bash
cd /opt
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
sudo rm -rf nvim
sudo tar -xzf nvim-linux-x86_64.tar.gz
sudo mv nvim-linux-x86_64.tar.gz nvim
sudo rm -rf nvim-linux-x86_64.tar.gz
echo 'PATH="$PATH:/opt/nvim/bin"' >> ~/.bashrc
```

## npm & nvm

```bash
sudo apt install nvm -y
nvm install --lts
```

## Build-essential (apt)

```bash
sudo apt install build-essential -y
```

## Unzip (apt)

```bash
sudo apt install unzip -y
```

## cargo and rustup

```bash
curl --proto '=https' --tlsv1.2 https://sh.rustup.rs -sSf | sh
echo 'PATH="$HOME/.cargo/bin/"' >> ~/.bashrc
```

## Tree-sitter-cli

```bash
cargo install tree-sitter-cli -y
```

## Nerd font

Linux:

(Install the font to $HOME first, JetBrainsMono used in example)

```bash
mkdir -p ~/.local/share/fonts
unzip JetBrainsMono.zip -d ~/.local/share/fonts/
fc-cache -fv
```

WSL: Download, Install from explorer, do `Ctrl+,` and edit JSON

## Deno

Deno for `peek.nvim`'s web assets

```bash
curl -fsSL https://deno.land/install.sh | sh
```

## wslu (for WSL)

`wslu` with `xdg-open` configured to open Chrome in WSL for `peek.nvim`

```bash
sudo apt install wslu -y
sudo ln -sf /usr/bin/wslview /usr/local/bin/xdg-open
echo "export BROWSER=wslview" >> ~/.bashrc
```

## Helpful alias

For looking at plugins `alias vpdir='cd ~/.local/share/nvim/site/pack/core/opt'`

```bash
echo "alias vpdir=\"cd ~/.local/share/nvim/site/pack/core/opt\"" >> ~/.bash_aliases
```
