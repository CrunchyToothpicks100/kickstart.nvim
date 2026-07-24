-- Linting

vim.pack.add { 'https://github.com/mfussenegger/nvim-lint' }

local lint = require 'lint'
lint.linters_by_ft = {
  -- Run Oxlint and ESLint alongside the Biome LSP for web files.
  javascript = { 'oxlint', 'eslint_d' },
  javascriptreact = { 'oxlint', 'eslint_d' },
  json = { 'eslint_d' },
  jsonc = { 'eslint_d' },
  markdown = { 'markdownlint' },
  python = { 'ruff', 'mypy' },
  astro = { 'eslint_d', 'oxlint' },
  sh = { 'shellcheck' },
  typescript = { 'oxlint', 'eslint_d' },
  typescriptreact = { 'oxlint', 'eslint_d' },
}

-- Follow sourced files (e.g. `source ./lib.sh`) instead of warning SC1091
table.insert(lint.linters.shellcheck.args, '-x')

-- Create autocommand which carries out the actual linting
-- on the specified events.
local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
  group = lint_augroup,
  callback = function()
    -- Only run the linter in buffers that you can modify in order to
    -- avoid superfluous noise, notably within the handy LSP pop-ups that
    -- describe the hovered symbol using Markdown.
    if vim.bo.modifiable then lint.try_lint() end
  end,
})

vim.api.nvim_create_user_command('LintInfo', function()
  local filetype = vim.bo.filetype
  local linters = require('lint').linters_by_ft[filetype]

  if linters then
    print('Linters for ' .. filetype .. ': ' .. table.concat(linters, ', '))
  else
    print('No linters configured for filetype: ' .. filetype)
  end
end, {})
