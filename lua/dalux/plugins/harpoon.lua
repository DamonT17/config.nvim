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

    -- Keymaps
    local wk = require('which-key')
    wk.register({
      ['h'] = {
        name = '[H]arpoon',
        ['a'] = {
          function()
            harpoon:list():append()
          end,
          '[A]ppend buffer to list',
        },
        ['c'] = {
          function()
            harpoon:list():clear()
          end,
          '[C]lear list of buffers',
        },
        ['h'] = {
          function()
            local toggle_opts = {
              border = 'rounded',
              title = ' Harpoon ',
              title_pos = 'center',
            }

            harpoon.ui:toggle_quick_menu(harpoon:list(), toggle_opts)
          end,
          '[H]arpoon menu',
        },
        ['n'] = {
          function()
            harpoon:list():next()
          end,
          '[N]ext buffer',
        },
        ['p'] = {
          function()
            harpoon:list():prev()
          end,
          '[P]revious buffer',
        },
        ['r'] = {
          function()
            harpoon:list():remove()
          end,
          '[R]emove buffer',
        },
        ['t'] = {
          function()
            toggle_telescope(harpoon:list())
          end,
          'Harpoon via [T]elescope menu',
        },
        ['v'] = {
          name = '[V]ertical split open',
          ['1'] = {
            function()
              harpoon:list():select(1, { vsplit = true })
            end,
            '[1]st buffer',
          },
          ['2'] = {
            function()
              harpoon:list():select(2, { vsplit = true })
            end,
            '[2]nd buffer',
          },
          ['3'] = {
            function()
              harpoon:list():select(3, { vsplit = true })
            end,
            '[3]rd buffer',
          },
          ['4'] = {
            function()
              harpoon:list():select(4, { vsplit = true })
            end,
            '[4]th buffer',
          },
          ['5'] = {
            function()
              harpoon:list():select(5, { vsplit = true })
            end,
            '[5]th buffer',
          },
        },
        ['1'] = {
          function()
            harpoon:list():select(1)
          end,
          '[1]st buffer',
        },
        ['2'] = {
          function()
            harpoon:list():select(2)
          end,
          '[2]nd buffer',
        },
        ['3'] = {
          function()
            harpoon:list():select(3)
          end,
          '[3]rd buffer',
        },
        ['4'] = {
          function()
            harpoon:list():select(4)
          end,
          '[4]th buffer',
        },
        ['5'] = {
          function()
            harpoon:list():select(5)
          end,
          '[5]th buffer',
        },
      },
    }, { mode = 'n', prefix = '<leader>' })
  end,
}
