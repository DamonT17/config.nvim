return {
  -- [[ Plugin: stevearc/oil.nvim ]]
  -- NOTE: See `:help oil.txt` or https://github.com/stevearc/oil.nvim for more info
  'stevearc/oil.nvim',
  dependencies = { 'nvim-mini/mini.icons' },
  config = function()
    require('oil').setup({
      columns = { 'icon' },
      keymaps = {
        ['<C-h>'] = false,
        ['<C-l>'] = false,
        ['<C-r>'] = 'actions.refresh',
      },
      view_options = {
        show_hidden = true,
      },
    })

    -- [[ Keymaps ]]
    -- Open parent directory in current window
    vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })
    -- Open parent directory in floating window
    vim.keymap.set('n', '<leader>-', require('oil').toggle_float, { desc = '[-] Open parent directory' })
  end,
}
