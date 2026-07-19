# Install help

## Git

```bash
sudo apt install git -y
git config --global user.email "your_email@example.com"
git config --global user.name "your_name"
```

## Neovim itself (from curl)

```bash
cd /opt
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
sudo rm -rf nvim-linux
sudo tar -xzf nvim-linux-x86_64.tar.gz
sudo mv nvim-linux-x86_64.tar.gz nvim
sudo rm -rf ~/nvim-linux-x86_64.tar.gz
```

Add to bashrc: `PATH="$PATH:/opt/nvim/bin"`

## npm & nvm

```bash
sudo apt install nvm -y
nvm install --lts
```

## Build-essentials (apt)

```bash
sudo apt install build-essentials -y
```

## Unzip (apt)

```bash
sudo apt install unzip -y
```

## Tree-sitter-cli

```bash
cd /usr/local/bin
sudo curl -LO https://github.com/tree-sitter/tree-sitter/releases/download/v0.26.11/tree-sitter-linux-x64.gz
sudo rm -rf tree-sitter
sudo gunzip tree-sitter-linux-x64.gz
sudo mv tree-sitter-linux-x64 tree-sitter
sudo chmod +x tree-sitter
```

Add to bashrc: `PATH="$PATH:/usr/local/bin/tree-sitter"`

## Nerd font

Install from explorer, do `Ctrl+,` and edit JSON

## Deno

Deno for `peek.nvim`'s web assets

```bash
curl -fsSL https://deno.land/install.sh | sh
```

## wslu

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
