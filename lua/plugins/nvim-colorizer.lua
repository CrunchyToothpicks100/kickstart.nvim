-- Shows color preview for CSS

-- The original repository is unmaintained and uses APIs removed by Nvim 0.13.
vim.pack.add { 'https://github.com/catgoose/nvim-colorizer.lua' }

-- Ensure the plugin is loaded before configuring
local status_ok, colorizer = pcall(require, 'colorizer')
if status_ok then
  colorizer.setup({
    -- '*' activates highlighting for all filetypes
    '*',
    -- Custom rules for specific filetypes
    css = { rgb_fn = true, hsl_fn = true },
    html = { names = false },
  }, {
    -- Global fallback options
    RGB = true, -- #RGB hex codes
    RRGGBB = true, -- #RRGGBB hex codes
    names = true, -- "Name" codes like Blue or Red
    RRGGBBAA = true, -- #RRGGBBAA hex codes
    rgb_fn = true, -- CSS rgb() and rgba() functions
    hsl_fn = true, -- CSS hsl() and hsla() functions
    css = true, -- Enable all CSS features
    css_fn = true, -- Enable all CSS functions
    mode = 'background', -- Set the display mode: 'background', 'foreground'
  })
end
