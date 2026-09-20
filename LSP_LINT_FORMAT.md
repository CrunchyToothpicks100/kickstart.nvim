# LSP, linting, and formatting

## Plugins

- LSP: `nvim-lspconfig` with Neovim's built-in LSP client
- Linting: `nvim-lint`
- Formatting: `conform.nvim`

LSP formatting is disabled globally for Conform with `lsp_format = 'never'`.
Formatting on save runs through Conform with a 500 ms timeout. Manual formatting
is also available with `<leader>f`.

`nvim-lint` runs on `BufEnter`, `BufWritePost`, and `InsertLeave` for modifiable
buffers.

## Filetypes

| Filetype | LSP | Linters | Formatter |
| --- | --- | --- | --- |
| Lua | `lua_ls` | — | `stylua` |
| Python | `ty` | `ruff` | `ruff_format` |
| HTML | `html` | — | `biome` |
| CSS | `cssls` | — | `biome` |
| JavaScript | `ts_ls` | — | `biome` |
| JSX | `ts_ls` | — | `biome` |
| TypeScript | `ts_ls` | — | `biome` |
| TSX | `ts_ls` | — | `biome` |
| Astro | `astro` | — | `prettierd`, then `prettier` |
| JSON | `jsonls` | — | `biome` |
| JSONC | `jsonls` | — | `biome` |
| Markdown | — | `markdownlint` | — |
| Shell | — | `shellcheck` | — |

### Notes

- `ts_ls` provides JavaScript and TypeScript type checking, completion,
navigation, references, hover information, and symbol operations. It attaches
to JavaScript, JSX, TypeScript, and TSX buffers.
- `jsonls` provides JSON and JSONC validation, completion, navigation, and
JSON Schema support. `html` and `cssls` provide language-aware completion,
navigation, and diagnostics for HTML and CSS, respectively.
- Biome is invoked by Conform as the formatter for web files. It is not enabled
as an LSP in the current configuration, so its lint diagnostics and code
actions are not active in Neovim.
- The Astro LSP attaches only to Astro buffers. Astro formatting remains
with Prettier because Biome is not configured for Astro.
- `ruff_format` is the Conform formatter. Ruff's project settings belong
in `pyproject.toml`, `ruff.toml`, or `.ruff.toml`.
- Lua formatting is handled by `stylua`; `stylua` is not an LSP.
