return {
  -- [[ Plugin: folke/which-key.nvim ]]
  -- NOTE: See `:help which-key.nvim.txt` or https://github.com/folke/which-key.nvim for more info
  'folke/which-key.nvim',
  event = 'VeryLazy',
  config = function()
    require('which-key').setup({
      window = {
        border = 'rounded',
        winblend = 10,
      },
      layout = {
        height = { min = 5, max = 20 }, -- min & max height of the columns
        width = { min = 20, max = 50 }, -- min & max width of the columns
        spacing = 2, -- spacing between columns
        align = 'center',
      },
    })

    -- Document existing key chains
    require('which-key').register({
      ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
      ['<leader>d'] = { name = '[D]ocument', _ = 'which_key_ignore' },
      ['<leader>g'] = { name = '[G]it', _ = 'which_key_ignore' },
      ['<leader>gt'] = { name = '[T]oggle', _ = 'which_key_ignore' },
      ['<leader>h'] = { name = '[H]arpoon', _ = 'which_key_ignore' },
      ['<leader>hv'] = { name = '[V]ertical split open', _ = 'which_key_ignore' },
      ['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
      ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
      ['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
    })
  end,
}
