return {
  -- [[ Plugin: numToStr/Comment.nvim ]]
  -- NOTE: See `:help comment-nvim.txt` or https://github.com/numToStr/Comment.nvim for more info
  {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup({})
    end,
  },

  -- [[ Plugin: Mini.nvim modules ]]
  -- Collection of various small independent plugins/modules
  -- NOTE: See `:help mini-###.txt` for more info on any mini module (e.g., `:help mini-ai.txt`)
  {
    'echasnovski/mini.nvim',
    config = function()
      -- Better Around/Inside text objects
      require('mini.ai').setup({ n_lines = 500 })

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      require('mini.surround').setup()
    end,
  },

  -- [[ Plugin: danymat/neogen ]]
  -- NOTE: See `:help neogen.txt` or https://github.com/danymat/neogen for more info
  -- {
  --   'danymat/neogen',
  --   version = '*',
  --   config = function()
  --     local neogen = require('neogen')
  --     neogen.setup({
  --       snippet_engine = 'luasnip',
  --     })
  --
  --     -- [[ Neogen keymaps ]]
  --     local wk = require('which-key')
  --     wk.register({
  --       ['n'] = {
  --         name = '[N]eogen',
  --         ['g'] = {
  --           neogen.generate(),
  --           '[G]enerate annotations',
  --         },
  --       },
  --     }, { mode = 'n', prefix = '<leader>' })
  --   end,
  -- },
}
