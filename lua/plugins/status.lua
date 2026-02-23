return {
  ---@package nvim-lualine/lualine.nvim
  --- NOTE: See `:help lualine.txt` or https://github.com/nvim-lualine/lualine.nvim for more info
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-mini/mini.icons' },
  opts = {
    options = {
      theme = 'catppuccin',
    },
    sections = {
      lualine_c = {
        {
          'filename',
          path = 1, -- Relative path
        },
      },
      lualine_x = {
        {
          'copilot',
          symbols = {
            status = {
              hl = {
                enabled = '#A6E3A1',
                sleep = '#A6ADC8',
                disabled = '89B4FA',
                warning = '#F9E2AF',
                unknown = '#F38BA8',
              },
            },
            spinners = require('copilot-lualine.spinners').dots,
            spinner_color = '#89B4FA',
          },
          show_colors = true,
          show_loading = true,
        },
        'encoding',
        'fileformat',
        'filetype',
      },
    },
  },
  config = function(_, opts)
    require('mini.icons').setup()
    require('mini.icons').mock_nvim_web_devicons()
    require('lualine').setup(opts)
  end,
}
