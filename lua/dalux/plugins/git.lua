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
        -- Keybindings
        local gs = package.loaded.gitsigns
        local wk = require('which-key')
        wk.register({
          ['[c'] = {
            function()
              if vim.wo.diff then
                return '[c'
              end

              vim.schedule(function()
                gs.prev_hunk()
              end)

              return '<Ignore>'
            end,
            'Previous hunk',
            expr = true,
          },
          [']c'] = {
            function()
              if vim.wo.diff then
                return ']c'
              end

              vim.schedule(function()
                gs.next_hunk()
              end)

              return '<Ignore>'
            end,
            'Next hunk',
            expr = true,
          },
          ['g'] = {
            name = '[G]itsigns',
            ['b'] = {
              function()
                gs.blame_line({ full = true })
              end,
              '[B]lame line',
            },
            ['d'] = {
              gs.diffthis,
              '[D]iff this',
            },
            ['D'] = {
              function()
                gs.diffthis('~')
              end,
              '[D]iff this (~)',
            },
            ['p'] = {
              gs.preview_hunk,
              '[P]review hunk',
            },
            ['r'] = {
              gs.reset_hunk,
              '[R]eset hunk',
            },
            ['R'] = {
              gs.reset_buffer,
              '[R]eset buffer',
            },
            ['s'] = {
              gs.stage_hunk,
              '[S]tage hunk',
            },
            ['S'] = {
              gs.stage_buffer,
              '[S]tage buffer',
            },
            ['t'] = {
              name = '[T]oggle',
              ['b'] = {
                gs.toggle_current_line_blame,
                'Toggle [B]lame',
              },
              ['d'] = {
                gs.toggle_deleted,
                'Toggle [D]eleted',
              },
            },
            ['u'] = {
              gs.undo_stage_hunk,
              '[U]ndo stage hunk',
            },
          },
        }, { mode = 'n', prefix = '<leader>' })

        wk.register({
          ['g'] = {
            name = '[G]itsigns',
            ['r'] = {
              function()
                gs.reset_hunk({
                  vim.fn.line('.'),
                  vim.fn.line('v'),
                })
              end,
              '[R]eset hunk',
            },
            ['s'] = {
              function()
                gs.stage_hunk({
                  vim.fn.line('.'),
                  vim.fn.line('v'),
                })
              end,
              '[S]tage hunk',
            },
          },
        }, { mode = 'v', prefix = '<leader>' })

        -- Text object
        -- map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
      end,
    })
  end,
}
