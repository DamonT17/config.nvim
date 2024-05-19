return {
  -- [[ Plugin: 'ThePrimeagen/harpoon' ]]
  -- NOTE: See https://github.com/ThePrimeagen/harpoon/tree/harpoon2 for more info
  'ThePrimeagen/harpoon',
  event = 'VeryLazy',
  branch = 'harpoon2',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
  },
  config = function()
    local harpoon = require('harpoon')
    harpoon.setup({})

    -- Telescope integration
    local conf = require('telescope.config').values
    local function toggle_telescope(harpoon_files)
      local file_paths = {}
      for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
      end

      require('telescope.pickers')
        .new({}, {
          prompt_title = 'Harpoon',
          finder = require('telescope.finders').new_table({
            results = file_paths,
          }),
          previewer = conf.file_previewer({}),
          sorter = conf.generic_sorter({}),
        })
        :find()
    end

    -- [[ Keymaps ]]
    ---Maps a key sequence to a function with a description.
    ---@param keys string Sequence of keys
    ---@param func any Function to call
    ---@param desc string Description of the keymap
    local map = function(keys, func, desc)
      vim.keymap.set('n', keys, func, { desc = desc })
    end

    map('<leader>ha', function()
      harpoon:list():append()
    end, '[A]ppend buffer to list')
    map('<leader>hc', function()
      harpoon:list():clear()
    end, '[C]lear list of buffers')
    map('<leader>hh', function()
      local toggle_opts = {
        border = 'rounded',
        title = ' Harpoon ',
        title_pos = 'center',
      }

      harpoon.ui:toggle_quick_menu(harpoon:list(), toggle_opts)
    end, '[H]arpoon menu')
    map('<leader>hn', function()
      harpoon:list():next()
    end, '[N]ext buffer')
    map('<leader>hp', function()
      harpoon:list():prev()
    end, '[P]revious buffer')
    map('<leader>hr', function()
      harpoon:list():remove()
    end, '[R]emove buffer')
    map('<leader>ht', function()
      toggle_telescope(harpoon:list())
    end, 'Harpoon via [T]elescope menu')

    -- Open buffer in horizontal split
    map('<leader>h1', function()
      harpoon:list():select(1)
    end, '[1]st buffer')
    map('<leader>h2', function()
      harpoon:list():select(2)
    end, '[2]nd buffer')
    map('<leader>h3', function()
      harpoon:list():select(3)
    end, '[3]rd buffer')
    map('<leader>h4', function()
      harpoon:list():select(4)
    end, '[4]th buffer')
    map('<leader>h5', function()
      harpoon:list():select(5)
    end, '[5]th buffer')

    -- Open buffer in vertical split
    map('<leader>hv1', function()
      harpoon:list():select(1, { vsplit = true })
    end, '[1]st buffer')
    map('<leader>hv2', function()
      harpoon:list():select(2, { vsplit = true })
    end, '[2]nd buffer')
    map('<leader>hv3', function()
      harpoon:list():select(3, { vsplit = true })
    end, '[3]rd buffer')
    map('<leader>hv4', function()
      harpoon:list():select(4, { vsplit = true })
    end, '[4]th buffer')
    map('<leader>hv5', function()
      harpoon:list():select(5, { vsplit = true })
    end, '[5]th buffer')
  end,
}
