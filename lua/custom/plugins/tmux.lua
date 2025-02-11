return {
  -- [[ Plugin: aserowy/tmux.nvim ]]
  -- NOTE: See https://github.com/aserowy/tmux.nvim for more info
  'aserowy/tmux.nvim',
  config = function()
    require('tmux').setup({})
  end,
}
