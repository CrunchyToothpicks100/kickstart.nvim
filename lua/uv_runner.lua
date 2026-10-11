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

--- Read optional overrides from <project-root>/.nvim/uv.json.
--- Example:
--- {
---   "build_args": ["--no-sources"],
---   "default_package": "helloworld"
--- }
--- Read each line into a table of strings, concat with '\n', decode it into a config table
--- pcall to catch parsing error
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

--- Get optional extra UV build arguments from the config
--- If the setting is missing or invalid, return an empty list
--- else return its list of string arguments to use in shell_command
local function build_args(config, key)
  local args = config[key]
  if args == nil then return {} end
  if type(args) ~= 'table' or not vim.islist(args) then
    notify(('%s must be an array of strings. Ignoring it.'):format(key), vim.log.levels.WARN)
    return {}
  end

  local result = {}
  for _, arg in ipairs(args) do
    if type(arg) ~= 'string' then
      notify(('%s must contain only strings. Ignoring it.'):format(key), vim.log.levels.WARN)
      return {}
    end
    table.insert(result, arg)
  end
  return result
end

--- Convert list of strings into shell command
--- Escapes chars
local function shell_command(arguments)
  return table.concat(vim.tbl_map(vim.fn.shellescape, arguments), ' ')
end

--- Splits window into terminal, closes after key press
local function open_terminal(command)
  vim.cmd('split | term ' .. command)
  vim.cmd 'startinsert'
end

--- Gets project info for the current buffer.
---
--- This is public so other integrations (such as DAP) can share the same
--- project-root discovery and .nvim/uv.json handling.
function M.get_project()
  local root = project_root()
  if not root then return nil end --- Could not find pyproject.toml to determine root

  local config = read_config(root)
  if not config then return nil end --- JSON un-parseable

  return {
    root = root,
    build_args = build_args(config, 'build_args'),
    default_package = config.default_package
  }
end

--- Input package, for building and running
local function prompt_pkg()
  local pkg = vim.trim(vim.fn.input 'UV package (leave blank to use default): ')
  if pkg == '' then return nil end
  return pkg
end

--- Build package
local function build_command(pkg, extra_args)
  return shell_command(vim.list_extend({'uv', 'build', '--package', pkg}, extra_args))
end

--- Run package
local function run_command(pkg)
  return shell_command { 'uv', 'run', pkg }
end

function M.setup()
  vim.keymap.set('n', '<leader>ur', function()
    local current = M.get_project()
    if not current then return end

    local pkg = prompt_pkg()
    if not pkg then
      if not current.default_package then
        notify('No default_package configured.')
        return
      end
      pkg = current.default_package
    end

    open_terminal(run_command(pkg))
  end, { desc = 'UV: [R]un package' })

  vim.keymap.set('n', '<leader>ub', function()
    local current = M.get_project()
    if not current then return end

    local pkg = prompt_pkg()
    if not pkg then
      if not current.default_package then
        notify('No default_package configured.')
        return
      end
      pkg = current.default_package
    end

    local full_command = build_command(pkg, current.build_args)
    open_terminal(full_command)
  end, { desc = 'UV: [B]uild package' })
end

return M
