return {
  -- [[ Plugin: folke/which-key.nvim ]]
  -- NOTE: See `:help which-key.nvim.txt` or https://github.com/folke/which-key.nvim for more info
  'folke/which-key.nvim',
  event = 'VeryLazy',
  opts = {
    preset = 'modern',
    win = {
      wo = {
        winblend = 10,
      },
    },
    layout = {
      align = 'center',
    },
    icons = {
      keys = {
        BS = '󰁮 ',
      },
    },
    spec = {
      { '<leader>c', group = '[C]ode' },
      { '<leader>d', group = '[D]ocument' },
      { '<leader>g', group = '[G]it', icon = { icon = '󰊢 ', hl = 'MiniIconsOrange' } },
      { '<leader>gt', group = '[T]oggle' },
      { '<leader>h', group = '[H]arpoon' },
      { '<leader>hv', group = '[V]ertical split open' },
      { '<leader>r', group = '[R]ename' },
      { '<leader>s', group = '[S]earch' },
      { '<leader>w', group = '[W]orkspace' },
    },
  },
}
