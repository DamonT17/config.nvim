return {
  -- [[ Plugin: nvimdev/dashboard-nvim ]]
  -- NOTE: See `:help dashboard.txt` or https://github.com/nvimdev/dashboard-nvim for more info
  'nvimdev/dashboard-nvim',
  event = 'VimEnter',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('dashboard').setup({
      theme = 'hyper',
      config = {
        week_header = { enable = true },
        packages = { enable = true },
        project = {
          enable = true,
          limit = 5,
          label = 'Projects',
          icon = '  ',
          action = function()
            -- Open selected directory using oil.nvim floating window
            require('oil').open_float()
          end,
        },
        mru = {
          limit = 10,
          label = 'Recent Files',
          icon = '  ',
          cwd_only = false,
        },
        footer = {
          '',
          "  It's not a bug; it's an undocumented feature.",
        },
      },
    })
  end,
  hide = {
    statusline = false,
    tabline = false,
    winbar = false,
  },
}
