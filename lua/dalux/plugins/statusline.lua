return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('lualine').setup({
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
    })
  end,
}
