return {
  -- [[ Plugin: lewis6991/gitsigns.nvim ]]
  -- NOTE: See `:help gitsigns.txt` or https://github.com/lewis6991/gitsigns.nvim for more info
  'lewis6991/gitsigns.nvim',
  config = function()
    require('gitsigns').setup({
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
        untracked = { text = '┆' },
      },
      word_diff = true,
      preview_config = {
        border = 'rounded',
        style = 'minimal',
        relative = 'cursor',
        row = 0,
        col = 1,
      },
      on_attach = function()
        -- [[ Keymaps ]]
        ---Maps a key sequence to a function with a description.
        ---@param mode string Mode to map the key sequence to
        ---@param keys string Sequence of keys
        ---@param func any Function to call
        ---@param desc string Description of the keymap
        local map = function(mode, keys, func, desc)
          vim.keymap.set(mode, keys, func, { desc = desc })
        end

        local gs = package.loaded.gitsigns
        map('n', '[h', function()
          if vim.wo.diff then
            return '[h'
          end

          vim.schedule(function()
            gs.prev_hunk()
          end)

          return '<Ignore>'
        end, 'Previous [H]unk')
        map('n', ']h', function()
          if vim.wo.diff then
            return ']h'
          end

          vim.schedule(function()
            gs.next_hunk()
          end)

          return '<Ignore>'
        end, 'Next [H]unk')

        -- Normal mode keymaps
        map('n', '<leader>gb', function()
          gs.blame_line({ full = true })
        end, '[B]lame line')
        map('n', '<leader>gd', gs.diffthis, '[D]iff this')
        map('n', '<leader>gD', function()
          gs.diffthis('~')
        end, '[D]iff this (~)')
        map('n', '<leader>gp', gs.preview_hunk, '[P]review hunk')
        map('n', '<leader>gr', gs.reset_hunk, '[R]eset hunk')
        map('n', '<leader>gR', gs.reset_buffer, '[R]eset buffer')
        map('n', '<leader>gs', gs.stage_hunk, '[S]tage hunk')
        map('n', '<leader>gS', gs.stage_buffer, '[S]tage buffer')
        map('n', '<leader>gtb', gs.toggle_current_line_blame, 'Toggle [B]lame')
        map('n', '<leader>gtd', gs.toggle_deleted, 'Toggle [D]eleted')
        map('n', '<leader>gu', gs.undo_stage_hunk, '[U]ndo stage hunk')

        -- Visual mode keymaps
        map('v', '<leader>gr', function()
          gs.reset_hunk({
            vim.fn.line('.'),
            vim.fn.line('v'),
          })
        end, '[R]eset hunk')
        map('v', '<leader>gs', function()
          gs.stage_hunk({
            vim.fn.line('.'),
            vim.fn.line('v'),
          })
        end, '[S]tage hunk')

        -- Text object
        -- map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
      end,
    })
  end,
}
