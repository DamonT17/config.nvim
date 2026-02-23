return {
  {
    ---@package mason-org/mason.nvim
    --- NOTE: See `:help mason.nvim` or https://github.com/mason-org/mason.nvim for more info
    'mason-org/mason.nvim',
    opts = {
      log_level = vim.log.levels.INFO,
      ui = {
        border = 'rounded',
        icons = {
          package_installed = '✓',
          package_pending = '➜',
          package_uninstalled = '✗',
        },
      },
    },
  },
  {
    ---@package mason-org/mason-lspconfig.nvim
    --- NOTE: See `:help mason-lspconfig.nvim` or https://github.com/mason-org/mason-lspconfig.nvim for more info
    'mason-org/mason-lspconfig.nvim',
    dependencies = { 'mason-org/mason.nvim', 'neovim/nvim-lspconfig' },
    opts = {
      ensure_installed = {
        'bashls',
        'clangd',
        'cmake',
        'copilot',
        'csharp_ls',
        'html',
        'lua_ls',
        'marksman',
        'pyright',
        'stylua',
      },
    },
  },
  {
    ---@package saghen/blink.cmp
    --- NOTE: See `:help blink-cmp` or https://github.com/saghen/blink.cmp for more info
    'saghen/blink.cmp',
    version = '1.*',
    dependencies = {
      {
        ---@package L3MON4D3/LuaSnip
        --- NOTE: See `:help luasnip.txt` or https://github.com/L3MON4D3/LuaSnip for more info
        'L3MON4D3/LuaSnip',
        version = 'v2.*',
        build = (function()
          if vim.fn.has('win32') == 1 or vim.fn.executable('make') == 0 then
            return
          end

          return 'make install_jsregexp'
        end)(),
        dependencies = {
          'rafamadriz/friendly-snippets', -- Snippets collection for LuaSnip
        },
        config = function()
          require('luasnip.loaders.from_vscode').lazy_load()

          -- Snippet extensions
          local ls = require('luasnip')
          ls.filetype_extend('cpp', { 'cppdoc', 'unreal' })
          ls.filetype_extend('csharp', { 'csharpdoc', 'unity' })
          ls.filetype_extend('lua', { 'luadoc' })
          ls.filetype_extend('ruby', { 'rails' })
        end,
      },
      {
        ---@package giuxtaposition/blink-cmp-copilot
        'giuxtaposition/blink-cmp-copilot',
      },
      {
        ---@package onsails/lspkind-nvim
        'onsails/lspkind-nvim',
      },
    },
    opts = {
      completion = {
        documentation = {
          auto_show = true,
          window = {
            border = 'rounded',
          },
        },
        ghost_text = { enabled = true },
        menu = {
          direction_priority = { 'n', 's' },
          draw = {
            components = {
              kind_icon = {
                text = function(ctx)
                  if ctx.item.kind_icon then
                    return ctx.item.kind_icon .. ctx.icon_gap
                  end

                  if vim.tbl_contains({ 'Path' }, ctx.source_name) then
                    local is_unknown_type =
                      vim.tbl_contains({ 'link', 'socket', 'fifo', 'char', 'block', 'unknown' }, ctx.item.data.type)
                    local mini_icon, _ = require('mini.icons').get(
                      is_unknown_type and 'os' or ctx.item.data.type,
                      is_unknown_type and '' or ctx.label
                    )
                    if mini_icon then
                      return mini_icon .. ctx.icon_gap
                    end
                  end

                  local icon = require('lspkind').symbol_map[ctx.kind] or ''
                  return icon .. ctx.icon_gap
                end,

                -- Optionally, use the highlight groups from mini.icons
                -- You can also add the same function for `kind.highlight` if you want to
                -- keep the highlight groups in sync with the icons.
                highlight = function(ctx)
                  if vim.tbl_contains({ 'Path' }, ctx.source_name) then
                    local is_unknown_type =
                      vim.tbl_contains({ 'link', 'socket', 'fifo', 'char', 'bloc', 'unknown' }, ctx.item.data.type)
                    local mini_icon, mini_hl, _ = require('mini.icons').get(
                      is_unknown_type and 'os' or ctx.item.data.type,
                      is_unknown_type and '' or ctx.label
                    )
                    if mini_icon then
                      return mini_hl
                    end
                  end

                  local icon, hl, _ = require('mini.icons').get('lsp', ctx.kind)
                  return hl
                end,
              },
              kind = {
                -- Optional, use highlights from mini.icons
                highlight = function(ctx)
                  if vim.tbl_contains({ 'Path' }, ctx.source_name) then
                    local is_unknown_type =
                      vim.tbl_contains({ 'link', 'socket', 'fifo', 'char', 'bloc', 'unknown' }, ctx.item.data.type)
                    local mini_icon, mini_hl, _ = require('mini.icons').get(
                      is_unknown_type and 'os' or ctx.item.data.type,
                      is_unknown_type and '' or ctx.label
                    )
                    if mini_icon then
                      return mini_hl
                    end
                  end

                  local icon, hl, _ = require('mini.icons').get('lsp', ctx.kind)
                  return hl
                end,
              },
            },
          },
        },
      },
      keymap = {
        preset = 'default',
        -- ['<Tab>'] = {
        --   'snippet_forward',
        --   function() -- sidekick next edit suggestion
        --     return require('sidekick').nes_jump_or_apply()
        --   end,
        --   function() -- if you are using Neovim's native inline completions
        --     return vim.lsp.inline_completion.get()
        --   end,
        --   'fallback',
        -- },
        ['<C-e>'] = { 'cancel', 'fallback' },
        ['<C-;>'] = {
          function() -- Selecting from a list of options (i.e., choice nodes))
            local luasnip = require('luasnip')
            if luasnip.choice_active() then
              luasnip.change_choice(1)
            end
          end,
          'fallback',
        },
      },
      snippets = { preset = 'luasnip' },
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer', 'copilot' },
        providers = {
          copilot = {
            name = 'copilot',
            module = 'blink-cmp-copilot',
            score_offset = 100,
            async = true,
            transform_items = function(_, items)
              for _, item in ipairs(items) do
                item.kind_icon = ' '
                item.kind_name = 'Copilot'
              end

              return items
            end,
          },
        },
      },
      cmdline = {
        keymap = { preset = 'inherit' },
        completion = { menu = { auto_show = true } },
      },
    },
  },
  {
    ---@package benfowler/telescope-luasnip.nvim
    'benfowler/telescope-luasnip.nvim',
    module = 'telescope._extensions.luasnip',
  },
  {
    ---@package j-hui/fidget.nvim
    --- NOTE: See `:help fidget.txt` or https://github.com/j-hui/fidget.nvim for more info
    'j-hui/fidget.nvim',
    version = '*',
    opts = {},
  },
}
