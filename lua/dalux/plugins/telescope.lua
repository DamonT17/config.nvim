return {
  -- [[ Plugin: nvim-telescope/telescope.nvim ]]
  -- NOTE: See `:help telescope.txt` or https://github.com/nvim-telescope/telescope.nvim for more info
  'nvim-telescope/telescope.nvim',
  event = 'VimEnter',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      cond = function()
        return vim.fn.executable('make') == 1
      end,
    },
    { 'nvim-telescope/telescope-ui-select.nvim' },
  },
  config = function()
    require('telescope').setup({
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown(),
        },
      },
    })

    -- Enable telescope extensions, if installed
    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')

    -- Keybindings
    local builtin = require('telescope.builtin')
    local wk = require('which-key')
    wk.register({
      ['s'] = {
        name = '[S]earch',
        ['d'] = {
          builtin.diagnostics,
          '[S]earch [D]iagnostics',
        },
        ['f'] = {
          builtin.find_files,
          '[S]earch [F]iles',
        },
        ['g'] = {
          builtin.live_grep,
          '[S]earch via [G]rep',
        },
        ['h'] = {
          builtin.help_tags,
          '[S]earch [H]elp',
        },
        ['k'] = {
          builtin.keymaps,
          '[S]earch [K]eymaps',
        },
        ['n'] = {
          function()
            builtin.find_files({
              cwd = vim.fn.stdpath('config'),
            })
          end,
          '[S]earch [N]eovim files',
        },
        ['r'] = {
          builtin.resume,
          '[S]earch [R]esume',
        },
        ['s'] = {
          builtin.builtin,
          '[S]earch [S]elect Telescope',
        },
        ['w'] = {
          builtin.grep_string,
          '[S]earch [W]ord',
        },
        ['.'] = {
          builtin.oldfiles,
          '[S]earch recent files ("." for repeat)',
        },
        ['/'] = {
          function()
            builtin.live_grep({
              grep_open_files = true,
              prompt_title = 'Live Grep in Open Files',
            })
          end,
          '[S]earch [/] in open files',
        },
      },
      ['<leader>'] = {
        builtin.buffers,
        '[ ] Find existing buffers',
      },
      ['/'] = {
        function()
          builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown({
            winblend = 10,
            previewer = false,
          }))
        end,
        '[/] Fuzzily search in current buffer',
      },
    }, { mode = 'n', prefix = '<leader>' })
  end,
}
