return {
  -- [[ Plugin: mfussenegger/nvim-dap ]]
  -- NOTE: See `:help dap.txt` or https://github.com/mfussenegger/nvim-dap for more info
  -- Each language requires installation and configuration of its own debug adapter
  'mfussenegger/nvim-dap',
  dependencies = {
    {
      'rcarriga/nvim-dap-ui',
      dependencies = {
        'nvim-neotest/nvim-nio',
      },
    },
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',
  },
  config = function()
    local dap = require('dap')
    local dapui = require('dapui')

    require('mason-nvim-dap').setup({
      ensure_installed = {
        'codelldb',
      },
      automatic_installation = true,
      handlers = {},
    })

    -- [[ Plugin: nvim-dap-ui ]]
    -- NOTE: See `:help nvim-dap-ui.txt` or https://github.com/rcarriga/nvim-dap-ui for more info
    dapui.setup({})
    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    -- Configure adapters
    dap.adapters.codelldb = {
      tye = 'executable',
      command = 'codelldb',
    }

    -- C/C++ configuration
    dap.configurations.cpp = {
      {
        name = 'Launch',
        type = 'codelldb',
        request = 'launch',
        program = function()
          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        args = {},
        env = function()
          local variables = {}
          for k, v in pairs(vim.fn.environ()) do
            table.insert(variables, string.format('%s=%s', k, v))
          end
          return variables
        end,
      },
    }
    dap.configurations.c = dap.configurations.cpp

    -- [[ Keymaps ]]
    ---Maps a key sequence to a function with a description.
    ---@param keys string Sequence of keys
    ---@param func any Function to call
    ---@param desc string Description of the keymap
    local map = function(keys, func, desc)
      vim.keymap.set('n', keys, func, { desc = desc })
    end

    map('<F5>', dap.continue, 'Debug: Start/Continue')
    map('<F1>', dap.step_into, 'Debug: Step Into')
    map('<F2>', dap.step_over, 'Debug: Step Over')
    map('<F3>', dap.step_out, 'Debug: Step Out')
    map('<F7>', dapui.toggle, 'Debug: See last session result')
    map('<leader>b', dap.toggle_breakpoint, 'Debug: Toggle [B]reakpoint')
    map('<leader>B', function()
      dap.set_breakpoint(vim.fn.input('Breakpoint condition: '))
    end, 'Debug: Set [B]reakpoint')
  end,
}
