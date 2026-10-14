local M = {}

--- Notify user
local function notify(message, level)
  vim.notify(message, level or vim.log.levels.ERROR, { title = 'UV runner' })
end

--- Searches down the directories until one contains 'pyproject.toml'
--- Notifies user if file isn't found
local function project_root()
  local root = vim.fs.root(0, 'pyproject.toml')
  if not root then
    notify 'Could not find pyproject.toml above the current buffer.'
    return nil
  end

  return root
end

--- Read optional command strings from <project-root>/.nvim/uv.json.
--- Example:
--- {
---   "build": "uv build --package helloworld",
---   "run": "uv run --package helloworld helloworld"
--- }
local function read_config(root)
  local path = root .. '/.nvim/uv.json'
  if vim.fn.filereadable(path) == 0 then return {} end

  local ok, config = pcall(vim.json.decode, table.concat(vim.fn.readfile(path), '\n'))
  if not ok or type(config) ~= 'table' then
    notify(('Could not parse %s as JSON.'):format(path))
    return nil
  end

  return config
end

--- Split window into terminal, run a shell command from the project root.
local function open_terminal(command, root)
  vim.cmd 'split'
  vim.cmd({ cmd = 'lcd', args = { root } })
  vim.cmd('terminal ' .. command)
end

--- Gets project info for the current buffer.
---
--- This is public so other integrations can share project-root discovery.
function M.get_project()
  local root = project_root()
  if not root then return nil end

  local config = read_config(root)
  if not config then return nil end

  return {
    root = root,
    build = config.build or '',
    run = config.run or '',
  }
end

local function configured_command(current, name)
  local command = current[name]
  if type(command) ~= 'string' then
    notify(('The %s command must be a string in .nvim/uv.json.'):format(name))
    return nil
  end
  if vim.trim(command) == '' then
    notify(('Set the %s command in .nvim/uv.json.'):format(name), vim.log.levels.WARN)
    return nil
  end

  return command
end

local function run_action(name)
  local current = M.get_project()
  if not current then return end

  local command = configured_command(current, name)
  if command then open_terminal(command, current.root) end
end

function M.setup()
  vim.keymap.set('n', '<leader>ub', function() run_action 'build' end, { desc = 'UV: [B]uild' })
  vim.keymap.set('n', '<leader>ur', function() run_action 'run' end, { desc = 'UV: [R]un' })
end

return M
