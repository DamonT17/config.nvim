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
      defaults = {
        layout_strategy = 'horizontal',
        layout_config = {
          horizontal = {
            height = 42, -- Previewer shows first 40 lines plus border
            preview_width = 120, -- Previewer shows 120 columns
          },
        },
        mappings = {
          i = {
            ['<CR>'] = 'file_vsplit',
          },
        },
        winblend = 10,
      },
      pickers = {
        diagnostics = {
          theme = 'dropdown',
        },
      },
      extensions = {
        ['luasnip'] = {
          require('telescope.themes').get_dropdown(),
        },
        ['ui-select'] = {
          require('telescope.themes').get_dropdown(),
        },
      },
    })

    -- Enable telescope extensions, if installed
    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'luasnip')
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
    map('<leader>sd', function()
      builtin.diagnostics(require('telescope.themes').get_dropdown({
        layout_config = {
          width = 120,
        },
      }))
    end, '[S]earch [D]iagnostics')
    map('<leader>sf', builtin.find_files, '[S]earch [F]iles')
    map('<leader>sg', builtin.live_grep, '[S]earch via [G]rep')
    map('<leader>sh', builtin.help_tags, '[S]earch [H]elp')
    map('<leader>sk', builtin.keymaps, '[S]earch [K]eymaps')
    map('<leader>sl', function()
      require('telescope').extensions.luasnip.luasnip()
    end, '[S]earch [L]uasnip')
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
        previewer = false,
        winblend = 10,
      }))
    end, '[/] Fuzzily search current buffer')
  end,
}
