# Install help

Update first: `sudo apt update`

## Clone the repository

```bash
sudo apt install git -y
cd ~/.config
git clone https://github.com/CrunchyToothpicks100/kickstart.nvim
mv kickstart.nvim/ nvim/
```

## Curl

```bash
sudo apt install curl -y
```

## Latest Neovim (from curl)

```bash
sudo curl -LO -o /opt/nvim.tar.gz https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
sudo rm -rf /opt/nvim
sudo tar -xzf /opt/nvim.tar.gz
sudo mv /opt/nvim-linux-x86_64 /opt/nvim
sudo rm -rf /opt/nvim.tar.gz
echo 'PATH="$PATH:/opt/nvim/bin"' >> ~/.bashrc
```

## npm & nvm

```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.8/install.sh | bash
source ~/.bashrc
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

Linux - This will install JetBrainsMono, you can edit this file

```bash
./install-nerd.sh
```

WSL or Windows - Download, Install from explorer, do `Ctrl+,` and edit JSON
to set the terminal profile's font manually

## Wayland Clipboard (for copy-pasting)

See if you are using Wayland or X11 with `echo $XDG_SESSION_TYPE`

```bash
sudo apt install wl-clipboard
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

## Deno for peek.nvim

Peek.nvim is a useful viewing tool for markdown files, however you will
need deno to build it

```bash
curl -fsSL https://deno.land/install.sh | sh
cd ~/.local/share/nvim/site/pack/core/opt
deno task --quiet build:fast
```

If you are running Linux (not WSL), you will need to edit this file and
change 'wsl-view' to 'firefox':

`~/.config/nvim/lua/plugins/peek.lua`

## Tmux

On Ubuntu, run the setup script from the Neovim config checkout:

```bash
bash tmux-setup/install.sh
```

The script installs tmux and git, backs up an existing `~/.tmux.conf`, installs
the config and TPM plugins, and adds Bash Readline bindings so Alt-h/j/k/l
reach tmux and Neovim. See [tmux-setup/README.md](tmux-setup/README.md) for details.
