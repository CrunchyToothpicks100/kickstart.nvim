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

--- Read optional overrides from <project-root>/.nvim/cmake.json.
--- Example:
--- {
---   "debug_build_dir": "out/debug",
---   "release_build_dir": "out/release",
---   "debug_configure_args": ["-DCMAKE_EXPORT_COMPILE_COMMANDS=ON"],
---   "release_configure_args": [],
---   "default_target": "helloworld"
--- }
--- Read each line into a table of strings, concat with '\n', decode it into a config table
--- pcall to catch parsing error
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

--- Create absolute build-directory paths based on values from the config
--- if there is no `value`, return default
--- if `value` is an absolute path (starts with '/'), use value
--- else use root/value
local function path_from_config(root, value, default)
  if value == nil then return default end
  if type(value) ~= 'string' then
    notify('Build-directory overrides must be strings.', vim.log.levels.WARN)
    return default
  end

  if value:sub(1, 1) == '/' then return vim.fs.normalize(value) end
  return vim.fs.normalize(root .. '/' .. value)
end

--- Get optional extra CMake configure arguments from the config
--- If the setting is missing or invalid, return an empty list
--- else return its list of string arguments to use in shell_command
local function configure_args(config, key)
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
--- project-root discovery and .nvim/cmake.json handling.
function M.get_project()
  local root = project_root()
  if not root then return nil end --- Could not find CMakeLists.txt to determine root

  local config = read_config(root)
  if not config then return nil end --- JSON un-parseable

  return {
    root = root,
    debug_dir = path_from_config(root, config.debug_build_dir, root .. '/build'),
    release_dir = path_from_config(root, config.release_build_dir, nil),
    debug_args = configure_args(config, 'debug_configure_args'),
    release_args = configure_args(config, 'release_configure_args'),
    default_target = config.default_target
  }
end

--- Input target executable, for building and running
local function prompt_target()
  local target = vim.trim(vim.fn.input 'CMake target (leave blank to use default): ')
  if target == '' then return nil end
  return target
end

--- Make builds
local function configure_command(root, build_dir, build_type, extra_args)
  return shell_command(vim.list_extend({
    'cmake',
    '-S',
    root,
    '-B',
    build_dir,
    '-D',
    'CMAKE_BUILD_TYPE=' .. build_type,
  }, extra_args))
end

--- Build targets
local function build_command(build_dir, target)
  return shell_command { 'cmake', '--build', build_dir, '--target', target }
end

function M.setup()
  vim.keymap.set('n', '<leader>cm', function()
    local current = M.get_project()
    if not current then return end -- no root or bad JSON

    local full_command = configure_command(current.root, current.debug_dir, 'Debug', current.debug_args)
    if current.release_dir then
      full_command = full_command .. ' && ' .. configure_command(current.root, current.release_dir, 'Release', current.release_args)
    end
    open_terminal(full_command)
  end, { desc = 'CMake: [M]ake Debug and/or Release config' })

  vim.keymap.set('n', '<leader>cr', function()
    local current = M.get_project()
    if not current then return end

    local target = prompt_target()
    if not target then
      if not current.default_target then
        notify('No default_target configured.')
        return
      end
      target = current.default_target
    end

    local build = build_command(current.debug_dir, target)
    local executable = vim.fn.shellescape(current.debug_dir .. '/' .. target)
    open_terminal(build .. ' && echo && ' .. executable)
  end, { desc = 'CMake: Build Debug target and [R]un' })

  vim.keymap.set('n', '<leader>cb', function()
    local current = M.get_project()
    if not current then return end

    local target = prompt_target()
    if not target then
      if not current.default_target then
        notify('No default_target configured.')
        return
      end
      target = current.default_target
    end

    local full_command = build_command(current.debug_dir, target)
    if current.release_dir then
      full_command = full_command .. ' && ' .. build_command(current.release_dir, target)
    end
    open_terminal(full_command)
  end, { desc = 'CMake: [B]uild target in Debug and Release' })
end

return M
