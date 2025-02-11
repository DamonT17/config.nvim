--- AI assistance plugins for Github Copilot integration.
--- NOTE: Copilot plugins are initialized here and further configured in ./lspconfig.lua and ./statusline.lua.

return {
  {
    -- [[ Plugin: zbirenbaum/copilot.lua ]]
    -- NOTE: See https://github.com/zbirenbaum/copilot.lua for more info
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    config = function()
      require('copilot').setup({
        suggestion = { enabled = false },
        panel = { enabled = false },
      })
    end,
  },
  {
    -- [[ Plugin: zbirenbaum/copilot-cmp  ]]
    -- NOTE: See https://github.com/zbirenbaum/copilot-cmp for more info
    'zbirenbaum/copilot-cmp',
    config = function()
      require('copilot_cmp').setup({})
    end,
  },
  {
    -- [[ Plugin: AndreM222/copilot-lualine ]]
    -- NOTE: See https://github.com/AndrewM222/copilot-lualine for more info
    'AndreM222/copilot-lualine',
  },
}
