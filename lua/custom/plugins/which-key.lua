return {
  -- [[ Plugin: folke/which-key.nvim ]]
  -- NOTE: See `:help which-key.nvim.txt` or https://github.com/folke/which-key.nvim for more info
  'folke/which-key.nvim',
  event = 'VeryLazy',
  opts = {
    preset = 'modern',
    win = {
      width = { min = 0.15, max = 0.5 },
      height = { min = 4, max = 25 },
      wo = {
        winblend = 10,
      },
    },
    keys = {
      scroll_down = '<C-f>',
      scroll_up = '<C-b>',
    },
    layout = {
      -- width = { min = 20, max = 50 },
      spacing = 3,
    },
    icons = {
      keys = {
        BS = '󰁮 ',
      },
    },
    spec = {
      { '<leader>b', group = '[B]uffer', icon = { icon = '󰈙 ', hl = 'MiniIconsAzure' } },
      { '<leader>c', group = '[C]ode', icon = { icon = ' ', hl = 'MiniIconsOrange' } },
      { '<leader>d', group = '[D]iagnostics', icon = { icon = '󱖫 ', hl = 'MiniIconsRed' } },
      { '<leader>de', vim.diagnostic.open_float, desc = '[E]rrors', icon = { icon = ' ', hl = 'MiniIconsRed' } },
      {
        '<leader>dq',
        vim.diagnostic.setloclist,
        desc = '[Q]uickfix',
        icon = { icon = ' ', hl = 'MiniIconsYellow' },
      },
      { '<leader>g', group = '[G]it', icon = { icon = '󰊢 ', hl = 'MiniIconsOrange' } },
      { '<leader>gt', group = '[T]oggle', icon = { icon = ' ', hl = 'MiniIconsOrange' } },
      { '<leader>h', group = '[H]arpoon', icon = { icon = '󱡀', hl = 'MiniIconsCyan' } },
      { '<leader>hv', group = '[V]ertical split open', icon = { icon = '󰯌 ', hl = 'MiniIconsPurple' } },
      { '<leader>r', group = '[R]ename', icon = { icon = '󰑕 ', hl = 'MiniIconsYellow' } },
      { '<leader>s', group = '[S]earch', icon = { icon = ' ', hl = 'MiniIconsGreen' } },
      { '<leader>w', group = '[W]orkspace', icon = { icon = ' ', hl = 'MiniIconsAzure' } },
    },
  },
}
