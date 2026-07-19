# Install help

Git

```bash
sudo apt install git -y
git config --global user.email "your_email@example.com"
git config --global user.name "your_name"
```

Neovim itself (from curl)

```bash
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
sudo rm -rf /opt/nvim-linux-x86_64
sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
echo "export PATH=\"$PATH:/opt/nvim-linux-x86_64/bin\"" >> ~/.bashrc
```

npm & nvm

```bash
sudo apt install nvm -y
nvm install --lts
```

Build-essentials (apt)

Unzip (apt)

Nerd font (install from explorer, do `Ctrl+,` and edit JSON)

Deno for `peek.nvim`'s web assets

```bash
curl -fsSL https://deno.land/install.sh | sh
```

`wslu` with `xdg-open` configured to open Chrome in WSL for `peek.nvim`

```bash
sudo apt install wslu -y
sudo ln -sf /usr/bin/wslview /usr/local/bin/xdg-open
echo "export BROWSER=wslview" >> ~/.bashrc
```

Helpful alias for looking at plugins `alias vpdir='cd ~/.local/share/nvim/site/pack/core/opt'`

```bash
echo "alias vpdir=\"cd ~/.local/share/nvim/site/pack/core/opt\"" >> ~/.bash_aliases
```
