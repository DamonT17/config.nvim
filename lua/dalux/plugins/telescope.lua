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

    -- [[ Keymaps ]]
    ---Maps a key sequence to a function with a description.
    ---@param keys string Sequence of keys
    ---@param func any Function to call
    ---@param desc string Description of the keymap
    local map = function(keys, func, desc)
      vim.keymap.set('n', keys, func, { desc = desc })
    end

    local builtin = require('telescope.builtin')
    map('<leader>sd', builtin.diagnostics, '[S]earch [D]iagnostics')
    map('<leader>sf', builtin.find_files, '[S]earch [F]iles')
    map('<leader>sg', builtin.live_grep, '[S]earch via [G]rep')
    map('<leader>sh', builtin.help_tags, '[S]earch [H]elp')
    map('<leader>sk', builtin.keymaps, '[S]earch [K]eymaps')
    map('<leader>sn', function()
      builtin.find_files({ cwd = vim.fn.stdpath('config') })
    end, '[S]earch [N]eovim files')
    map('<leader>sr', builtin.resume, '[S]earch [R]esume')
    map('<leader>ss', builtin.builtin, '[S]earch [S]elect Telescope')
    map('<leader>sw', builtin.grep_string, '[S]earch [W]ord')
    map('<leader>s.', builtin.oldfiles, '[S]earch recent files')
    map('<leader>s/', function()
      builtin.live_grep({ grep_open_files = true, prompt_title = 'Live Grep in Open Files' })
    end, '[S]earch open files')
    map('<leader><space>', builtin.buffers, '[ ] Find existing buffers')
    map('<leader>/', function()
      builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown({
        winblend = 10,
        previewer = false,
      }))
    end, '[/] Fuzzily search current buffer')
  end,
}
