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
  -- NOTE: See `:help mini-<module>.txt` for more info on any mini module (e.g., `:help mini-ai.txt`)
  {
    'echasnovski/mini.nvim',
    version = false,
    config = function()
      -- Better Around/Inside text objects
      require('mini.ai').setup({ n_lines = 500 })

      -- Additional icons
      require('mini.icons').setup()

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      require('mini.surround').setup()
    end,
  },

  -- [[ Plugin: folke/twilight.nvim ]]
  -- NOTE: See `:help twilight.txt` or https://github.com/folke/twilight.nvim for more info
  {
    'folke/twilight.nvim',
    opts = {},
  },

  -- [[ Plugin: folke/zen-mode.nvim ]]
  -- NOTE: See `:help zen-mode.nvim.txt` or https://github.com/folke/zen-mode.nvim for more info
  {
    'folke/zen-mode.nvim',
    opts = {
      border = 'rounded', -- Custom mod to zen-mode.nvim per changes in https://github.com/folke/zen-mode.nvim/pull/80
      window = {
        backdrop = 0.95,
        width = 130,
        height = 40,
      },
    },

    -- [[ Keymaps ]]
    vim.keymap.set('n', '<leader>z', function()
      require('zen-mode').toggle({})
    end, { desc = '[Z]en Mode' }),
  },

  -- [[ Plugin: benfowler/telescope-luasnip.nvim ]]
  -- NOTE: See `:help telescope-luasnip.txt` or https://github.com/benfowler/telescope-luasnip.nvim for more info
  {
    'benfowler/telescope-luasnip.nvim',
    module = 'telescope._extensions.luasnip',
  },
}
