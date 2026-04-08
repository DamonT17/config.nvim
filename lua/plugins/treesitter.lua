return {
  -- [[ Plugin: nvim-treesitter ]]
  -- NOTE: See `:help nvim-treesitter` or https://github.com/nvim-treesitter/nvim-treesitter for more info
  -- To inspect a buffer's treesitter syntax, the following commands can be used:
  --  `:Inspect`
  --  `:InspectTree`
  --  `:EditQuery`
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  dependencies = {
    {
      ---@package nvim-treesitter/nvim-treesitter-textobjects
      --- NOTE: See `:help nvim-treesitter-textobjects` or
      --- https://github.com/nvim-treesitter/nvim-treesitter-textobjects/tree/main for more info
      'nvim-treesitter/nvim-treesitter-textobjects',
      branch = 'main',
      init = function()
        vim.g.no_plugin_maps = true
      end,
      config = function()
        require('nvim-treesitter-textobjects').setup({
          select = {
            lookahead = true,
            include_surrounding_whitespace = false,
          },
          move = { set_jumps = true },
        })

        -- Keymaps
        -- Text objects (select)
        vim.keymap.set({ 'x', 'o' }, 'am', function()
          require('nvim-treesitter-textobjects.select').select_textobject('@function.outer', 'textobjects')
        end, { desc = 'Around [M]ethod' })
        vim.keymap.set({ 'x', 'o' }, 'im', function()
          require('nvim-treesitter-textobjects.select').select_textobject('@function.inner', 'textobjects')
        end, { desc = 'Inside [M]ethod' })
        vim.keymap.set({ 'x', 'o' }, 'ac', function()
          require('nvim-treesitter-textobjects.select').select_textobject('@class.outer', 'textobjects')
        end, { desc = 'Around [C]lass' })
        vim.keymap.set({ 'x', 'o' }, 'ic', function()
          require('nvim-treesitter-textobjects.select').select_textobject('@class.inner', 'textobjects')
        end, { desc = 'Inside [C]lass' })
        vim.keymap.set({ 'x', 'o' }, 'as', function()
          require('nvim-treesitter-textobjects.select').select_textobject('@local.scope', 'locals')
        end, { desc = 'Around [S]cope' })

        -- Swap
        vim.keymap.set('n', '<leader>ts', function()
          require('nvim-treesitter-textobjects.swap').swap_next('@parameter.inner')
        end, { desc = 'Swap [N]ext parameter' })
        vim.keymap.set('n', '<leader>tS', function()
          require('nvim-treesitter-textobjects.swap').swap_previous('@parameter.outer')
        end, { desc = 'Swap [P]rev parameter' })

        -- Navigation (next)
        vim.keymap.set({ 'n', 'x', 'o' }, ']m', function()
          require('nvim-treesitter-textobjects.move').goto_next_start('@function.outer', 'textobjects')
        end, { desc = 'Next function start' })
        vim.keymap.set({ 'n', 'x', 'o' }, ']C', function()
          require('nvim-treesitter-textobjects.move').goto_next_start('@class.outer', 'textobjects')
        end, { desc = 'Next class start' })
        vim.keymap.set({ 'n', 'x', 'o' }, ']o', function()
          require('nvim-treesitter-textobjects.move').goto_next_start({ '@loop.inner', '@loop.outer' }, 'textobjects')
        end, { desc = 'Next l[o]op' })
        vim.keymap.set({ 'n', 'x', 'o' }, ']s', function()
          require('nvim-treesitter-textobjects.move').goto_next_start('@local.scope', 'locals')
        end, { desc = 'Next [s]cope' })
        vim.keymap.set({ 'n', 'x', 'o' }, ']z', function()
          require('nvim-treesitter-textobjects.move').goto_next_start('@fold', 'folds')
        end, { desc = 'Next fold' })
        vim.keymap.set({ 'n', 'x', 'o' }, ']M', function()
          require('nvim-treesitter-textobjects.move').goto_next_end('@function.outer', 'textobjects')
        end, { desc = 'Next function end' })
        vim.keymap.set({ 'n', 'x', 'o' }, '][', function()
          require('nvim-treesitter-textobjects.move').goto_next_end('@class.outer', 'textobjects')
        end, { desc = 'Next class end' })
        vim.keymap.set({ 'n', 'x', 'o' }, ']?', function()
          require('nvim-treesitter-textobjects.move').goto_next('@conditional.outer', 'textobjects')
        end, { desc = 'Next conditional' })

        -- Navigation (prev)
        vim.keymap.set({ 'n', 'x', 'o' }, '[m', function()
          require('nvim-treesitter-textobjects.move').goto_previous_start('@function.outer', 'textobjects')
        end, { desc = 'Prev function start' })
        vim.keymap.set({ 'n', 'x', 'o' }, '[C', function()
          require('nvim-treesitter-textobjects.move').goto_previous_start('@class.outer', 'textobjects')
        end, { desc = 'Prev class start' })
        vim.keymap.set({ 'n', 'x', 'o' }, '[M', function()
          require('nvim-treesitter-textobjects.move').goto_previous_end('@function.outer', 'textobjects')
        end, { desc = 'Prev function end' })
        vim.keymap.set({ 'n', 'x', 'o' }, '[]', function()
          require('nvim-treesitter-textobjects.move').goto_previous_end('@class.outer', 'textobjects')
        end, { desc = 'Prev class end' })
        vim.keymap.set({ 'n', 'x', 'o' }, '[?', function()
          require('nvim-treesitter-textobjects.move').goto_previous('@conditional.outer', 'textobjects')
        end, { desc = 'Prev conditional' })

        local ts_repeat_move = require('nvim-treesitter-textobjects.repeatable_move')

        -- Repeat movement with ; and ,
        vim.keymap.set({ 'n', 'x', 'o' }, ';', ts_repeat_move.repeat_last_move_next, { desc = 'Repeat last move' })
        vim.keymap.set({ 'n', 'x', 'o' }, ',', ts_repeat_move.repeat_last_move_previous, { desc = 'Repeat last move (rev)' })

        -- Make builtin f, F, t, T repeatable with ; and ,
        vim.keymap.set({ 'n', 'x', 'o' }, 'f', ts_repeat_move.builtin_f_expr, { expr = true, desc = 'Find char forward' })
        vim.keymap.set({ 'n', 'x', 'o' }, 'F', ts_repeat_move.builtin_F_expr, { expr = true, desc = 'Find char backward' })
        vim.keymap.set({ 'n', 'x', 'o' }, 't', ts_repeat_move.builtin_t_expr, { expr = true, desc = 'Till char forward' })
        vim.keymap.set({ 'n', 'x', 'o' }, 'T', ts_repeat_move.builtin_T_expr, { expr = true, desc = 'Till char backward' })
      end,
    },
  },
  opts = {
    ensure_installed = {
      'bash',
      'c',
      'cpp',
      'c_sharp',
      'cmake',
      'doxygen',
      'html',
      'lua',
      'markdown',
      'python',
      'vim',
      'vimdoc',
    },
    auto_install = true,
    highlight = {
      enable = true,
      custom_captures = {
        ['comment.documentation'] = 'Identifier',
      },
    },
    indent = { enable = true },
  },
  config = function(_, opts)
    require('nvim-treesitter.config').setup(opts)
  end,
}
