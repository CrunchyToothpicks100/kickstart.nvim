# tmux setup

From this directory, run:

```bash
bash install.sh
```

The installer is for Ubuntu. It installs `tmux` and `git`, backs up an existing
`~/.tmux.conf`, installs TPM and the configured plugins, creates
`~/.tmux/logs`, and adds the Bash Readline bindings needed to pass Alt-h/j/k/l
through to tmux and Neovim. Run it again to refresh the config; the Bash block
is added only once.

The tmux keys use Alt-b as the prefix, Alt-h/j/k/l for pane navigation, and
Alt-Space for the next window. For navigation to cross between tmux panes and
Neovim splits, Neovim must also have `alexghergh/nvim-tmux-navigation` set up
with the matching Alt-h/j/k/l and Alt-Space mappings.
