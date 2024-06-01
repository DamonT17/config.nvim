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
          -- List 5 latest used directories
          action = function()
            require('telescope.builtin').file_browser({
              cwd = require('telescope.utils').buffer_dir(),
            })
          end,
        },
        mru = {
          limit = 5,
          label = 'Recent Files',
          icon = '  ',
          cwd_only = false,
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
