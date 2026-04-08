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
      {
        '<leader>a',
        group = '[A]ssistant',
        mode = { 'n', 'v', 'x' },
        icon = { icon = ' ', hl = 'MiniIconsPurple' },
      },
      { '<leader>b', group = '[B]uffer', icon = { icon = '󰈙 ', hl = 'MiniIconsPurple' } },
      { '<leader>c', group = '[C]ode', icon = { icon = ' ', hl = 'MiniIconsBlue' } },
      { '<leader>d', group = '[D]iagnostics', icon = { icon = '󱖫 ', hl = 'MiniIconsOrange' } },
      { '<leader>de', vim.diagnostic.open_float, desc = '[E]rrors', icon = { icon = ' ', hl = 'MiniIconsRed' } },
      {
        '<leader>dq',
        vim.diagnostic.setloclist,
        desc = '[Q]uickfix',
        icon = { icon = ' ', hl = 'MiniIconsYellow' },
      },
      { '<leader>f', group = '[F]ind', icon = { icon = '󰍉 ', hl = 'MiniIconsCyan' } },
      { '<leader>g', group = '[G]it', mode = { 'n', 'v' }, icon = { icon = '󰊢 ', hl = 'MiniIconsGreen' } },
      { '<leader>gt', group = '[T]oggle', icon = { icon = ' ', hl = 'MiniIconsGreen' } },
      { '<leader>h', group = '[H]arpoon', icon = { icon = '󱡀', hl = 'MiniIconsPurple' } },
      { '<leader>hv', group = '[V]ertical split open', icon = { icon = '󰯌 ', hl = 'MiniIconsPurple' } },
      { '<leader>j', group = 'Annotations', icon = { icon = '󰃃 ', hl = 'MiniIconsYellow' } },
      { '<leader>m', group = '[M]ini Surround', icon = { icon = '󰅲 ', hl = 'MiniIconsPurple' } },
      { '<leader>r', group = '[R]ename', icon = { icon = '󰑕 ', hl = 'MiniIconsBlue' } },
      { '<leader>t', group = '[T]extobject Ops', icon = { icon = '󱔁 ', hl = 'MiniIconsPurple' } },
      { '<leader>v', group = '[V]ersion Hunks', mode = { 'n', 'v' }, icon = { icon = '󰊢 ', hl = 'MiniIconsGreen' } },
      { '<leader>s', group = '[S]earch', icon = { icon = ' ', hl = 'MiniIconsCyan' } },
      { '<leader>u', group = '[U]tilities', icon = { icon = '󰟻 ', hl = 'MiniIconsGrey' } },
      { '<leader>w', group = '[W]orkspace', icon = { icon = ' ', hl = 'MiniIconsBlue' } },
      -- Text object groups (operator-pending + visual)
      { 'a', group = 'Around', mode = { 'x', 'o' } },
      { 'i', group = 'Inside', mode = { 'x', 'o' } },
      -- Goto groups (normal + visual + operator-pending)
      { 'g', group = 'Goto', mode = { 'n', 'x', 'o' } },
      { 'ga', group = 'C[a]lls', mode = 'n' },
      -- Navigation groups (normal + visual + operator-pending)
      { ']', group = 'Next', mode = { 'n', 'x', 'o' } },
      { '[', group = 'Prev', mode = { 'n', 'x', 'o' } },
    },
  },
}
