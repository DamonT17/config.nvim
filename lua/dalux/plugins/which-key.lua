return { -- Useful plugin to show you pending keybinds.
  'folke/which-key.nvim',
  event = 'VeryLazy', -- Sets the loading event to 'VimEnter'
  config = function() -- This is the function that runs, AFTER loading
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
      ['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
      ['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
    })
  end,
}
