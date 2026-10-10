# Neovim configuration

A personal Neovim configuration forked from [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim), extending its documented, customizable foundation with tools for everyday development.

Includes Telescope search, Neo-tree file browsing, Treesitter highlighting, Blink completion, Git signs, debugging, automatic pairs and tags, color previews, Markdown previews, and tmux navigation. Plugins use Neovim's built-in `vim.pack`, while Mason installs configured language servers and development tools. Start with `init.lua`; additional settings and plugins live under `lua/`.

## Installation

Use a recent Neovim build with `vim.pack` support. Back up your existing configuration before cloning. These steps target Ubuntu/Linux and WSL. Configuration paths are `~/.config/nvim` (or `$XDG_CONFIG_HOME/nvim`) on Linux/macOS and `%LOCALAPPDATA%\nvim` on Windows.

### Dependencies and checkout

```bash
sudo apt update
sudo apt install -y git curl build-essential unzip wget ripgrep fd-find
mkdir -p ~/.config
git clone https://github.com/CrunchyToothpicks100/kickstart.nvim.git ~/.config/nvim
cd ~/.config/nvim
```

`build-essential` provides the compiler and make tools needed for Treesitter and native plugins. Install language runtimes as needed, such as Node/npm for JavaScript and TypeScript or Go for Go projects.

### Neovim (Linux x86_64 release)

If your package manager's Neovim is too old, install the release archive in `/opt/nvim`. Move aside an existing `/opt/nvim` installation first.

```bash
cd /tmp
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
sudo mv /opt/nvim-linux-x86_64 /opt/nvim
echo 'export PATH="/opt/nvim/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
cd ~/.config/nvim
```

### Node/npm, Rust, and Treesitter CLI

```bash
# Node and npm through nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.8/install.sh | bash
source ~/.bashrc
nvm install --lts

# Rust and Cargo through rustup
curl --proto '=https' --tlsv1.2 https://sh.rustup.rs -sSf | sh
source "$HOME/.cargo/env"
cargo install tree-sitter-cli
```

If Cargo is missing from future shells, add `export PATH="$HOME/.cargo/bin:$PATH"` to `~/.bashrc`.

### Fonts and clipboard

On Linux, run `bash install-nerd.sh` from this checkout to install JetBrainsMono Nerd Font; edit the script to choose another font. On Windows/WSL, download and install the font in Windows, then open Windows Terminal settings with `Ctrl+,` and set the profile font in its JSON configuration. `vim.g.have_nerd_font` is enabled in `init.lua`; disable it if you do not use a Nerd Font. Optional Ubuntu emoji support: `sudo apt install fonts-noto-color-emoji`.

Check your display session with `echo "$XDG_SESSION_TYPE"`. For Wayland, run `sudo apt install wl-clipboard`; X11 users can use `xclip` or `xsel`, and Windows users can use `win32yank` or another clipboard provider.

### Markdown preview and WSL

Peek provides Markdown previews through `:PeekOpen` and `:PeekClose` and requires Deno:

```bash
curl -fsSL https://deno.land/install.sh | sh
```

Restart your shell and ensure `deno` is on your PATH. On WSL, configure `xdg-open` to use the Windows browser (set Chrome as the default browser if desired):

```bash
sudo apt install wslu -y
sudo ln -sf /usr/bin/wslview /usr/local/bin/xdg-open
echo 'export BROWSER=wslview' >> ~/.bashrc
```

The configuration builds Peek automatically. If previews fail, rebuild from the plugin directory:

```bash
cd ~/.local/share/nvim/site/pack/core/opt/peek.nvim
deno task --quiet build:fast
cd ~/.config/nvim
```

If needed, adjust `app` in [lua/plugins/peek.lua](lua/plugins/peek.lua) to use Firefox, `wslview`, or `xdg-open`.

### Tmux and first launch

On Ubuntu, run `bash tmux-setup/install.sh` from this checkout. It installs tmux and git, backs up an existing `~/.tmux.conf`, installs the configuration and TPM plugins, and adds Bash Readline bindings so Alt-h/j/k/l reach tmux and Neovim. See [tmux-setup/README.md](tmux-setup/README.md) for details.

Run `nvim` to install plugins. Inspect plugin state with `:lua vim.pack.update(nil, { offline = true })`, or fetch updates with `:lua vim.pack.update()` (`:write` applies them; `:quit` cancels). Run `:checkhealth` to diagnose missing dependencies.

For quick access to installed plugins, add this to `~/.bash_aliases`:

```bash
alias vpdir='cd ~/.local/share/nvim/site/pack/core/opt'
```

To keep another configuration alongside this one, clone into `~/.config/nvim-kickstart` and launch with `NVIM_APPNAME=nvim-kickstart nvim`; its data lives separately under `~/.local/share/nvim-kickstart`.

## LSP, linting, and formatting

`nvim-lspconfig` configures Neovim's built-in LSP client, `nvim-lint` runs linters, and `conform.nvim` handles formatting. Conform formats on save with a 500 ms timeout and manually with `<leader>f`. LSP formatting is disabled via `lsp_format = 'never'`. Linters run on `BufEnter`, `BufWritePost`, and `InsertLeave` for modifiable buffers.

| Filetype | LSP | Linter | Formatter |
| --- | --- | --- | --- |
| Lua | `lua_ls` | — | `stylua` |
| Python | `ty` | `ruff` | `ruff_format` |
| C / C++ | `clangd` | — | `clang-format` |
| HTML | `html` | — | `biome` |
| CSS | `cssls` | — | `biome` |
| JavaScript / JSX | `ts_ls` | — | `biome` |
| TypeScript / TSX | `ts_ls` | — | `biome` |
| Astro | `astro` | — | `prettierd`, then `prettier` |
| JSON / JSONC | `jsonls` | — | `biome` |
| Markdown | — | `markdownlint` | — |
| Shell | — | `shellcheck` | — |

- `ts_ls` provides type checking, completion, navigation, references, hover information, and symbol operations for JavaScript, JSX, TypeScript, and TSX.
- `jsonls` provides validation, completion, navigation, and JSON Schema support for JSON and JSONC. `html` and `cssls` provide language-aware completion, navigation, and diagnostics.
- Biome is used only as a formatter; its LSP lint diagnostics and code actions are not enabled.
- The Astro LSP attaches only to Astro buffers. Astro uses Prettier because Biome is not configured for it.
- Python formatting uses Conform's `ruff_format`; configure Ruff in `pyproject.toml`, `ruff.toml`, or `.ruff.toml`.
- Lua formatting uses StyLua, which is a formatter rather than an LSP.
- C/C++ formatting requires `clang-format` to be installed manually and available on your PATH. On Ubuntu, run `sudo apt install clang-format`.
- C/C++ static analysis uses clang-tidy through `clangd` (`--clang-tidy`).
