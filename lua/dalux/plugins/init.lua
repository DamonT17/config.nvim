return {
  -- "gc" to comment visual regions/lines
  -- { 'numToStr/Comment.nvim', opts = {} },
  {
    -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      -- Better Around/Inside text objects
      require('mini.ai').setup({ n_lines = 500 })

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      require('mini.surround').setup()
    end,
  },
}
