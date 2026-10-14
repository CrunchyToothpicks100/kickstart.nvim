local M = {}

--- Notify user
local function notify(message, level)
  vim.notify(message, level or vim.log.levels.ERROR, { title = 'CMake runner' })
end

--- Searches down the directories until one contains 'CMakeLists.txt'
--- Notifies user if file isn't found
local function project_root()
  local root = vim.fs.root(0, 'CMakeLists.txt')
  if not root then
    notify 'Could not find CMakeLists.txt above the current buffer.'
    return nil
  end

  return root
end

--- Read optional command overrides from <project-root>/.nvim/cmake.json.
--- Example:
--- {
---   "make": "cmake -S . -B build",
---   "build": "cmake --build build --target my_app",
---   "run": "./build/my_app"
--- }
local function read_config(root)
  local path = root .. '/.nvim/cmake.json'
  if vim.fn.filereadable(path) == 0 then return {} end

  local ok, config = pcall(vim.json.decode, table.concat(vim.fn.readfile(path), '\n'))
  if not ok or type(config) ~= 'table' then
    notify(('Could not parse %s as JSON.'):format(path))
    return nil
  end

  return config
end

--- Gets project root and optional commands.
--- This is public so other integrations (such as DAP) can share project-root discovery.
function M.get_project()
  local root = project_root()
  if not root then return nil end

  local config = read_config(root)
  if not config then return nil end

  return {
    root = root,
    make = config.make or '',
    build = config.build or '',
    run = config.run or '',
  }
end

--- Split window into terminal, run a shell command from the project root.
local function open_terminal(command, root)
  vim.cmd 'split'
  vim.cmd({ cmd = 'lcd', args = { root } })
  vim.cmd('terminal ' .. command)
end

local function configured_command(current, name)
  local command = current[name]
  if type(command) ~= 'string' then
    notify(('The %s command must be a string in .nvim/cmake.json.'):format(name))
    return nil
  end
  if vim.trim(command) == '' then
    notify(('Set the %s command in .nvim/cmake.json.'):format(name), vim.log.levels.WARN)
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

local function build_and_run()
  local current = M.get_project()
  if not current then return end

  local build = configured_command(current, 'build')
  if not build then return end

  local run = configured_command(current, 'run')
  if not run then return end

  open_terminal(build .. ' && ' .. run, current.root)
end

function M.setup()
  vim.keymap.set('n', '<leader>cm', function() run_action 'make' end, { desc = 'CMake: [M]ake' })
  vim.keymap.set('n', '<leader>cb', function() run_action 'build' end, { desc = 'CMake: [B]uild' })
  vim.keymap.set('n', '<leader>cr', build_and_run, { desc = 'CMake: Build and [R]un' })
end

return M
