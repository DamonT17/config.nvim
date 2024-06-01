return {
  -- [[ Plugin lukas-reineke/indent-blankline.nvim ]]
  -- NOTE: See `:help indent_blankline.txt` or https://github.com/lukas-reineke/indent-blankline.nvim
  'lukas-reineke/indent-blankline.nvim',
  main = 'ibl',
  config = function()
    require('indent_blankline').setup({
      filetype_exclude = { 'dashboard' },
    })
  end,
}
