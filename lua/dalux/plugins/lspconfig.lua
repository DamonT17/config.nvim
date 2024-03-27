return {
  'neovim/nvim-lspconfig',
  event = { 'BufReadPre', 'BufNewFile' }, -- Sets the loading events to 'BufReadPre' and 'BufNewFile'
  dependencies = {
    -- Automatically install LSPs and related tools to stdpath for neovim
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',

    -- Autocompletion
    {
      'hrsh7th/nvim-cmp',
      event = 'InsertEnter',
      dependencies = {
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-nvim-lua',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        { -- Snippet Engine
          'L3MON4D3/LuaSnip',
          version = 'v2.*',
          build = (function()
            if vim.fn.has('win32') == 1 or vim.fn.executable('make') == 0 then
              return
            end

            return 'make install_jsregexp'
          end)(),
        },
        'saadparwaiz1/cmp_luasnip',
      },
      config = function()
        -- NOTE: See `:help cmp`
        local cmp_autopairs = require('nvim-autopairs.completion.cmp')
        local cmp = require('cmp')
        cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())

        local luasnip = require('luasnip')
        luasnip.config.setup({})

        local has_words_before = function()
          if vim.api.nvim_buf_get_option(0, 'buftype') == 'prompt' then
            return false
          end

          local line, col = unpack(vim.api.nvim_win_get_cursor(0))
          return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match('^%s*$') == nil
        end

        cmp.setup({
          window = {
            completion = cmp.config.window.bordered(),
            documentation = cmp.config.window.bordered(),
          },
          snippet = {
            expand = function(args)
              luasnip.lsp_expand(args.body)
            end,
          },
          completion = { completeopt = 'menu,menuone,noinsert' },

          -- NOTE: See `:help ins-completion`
          mapping = cmp.mapping.preset.insert({
            -- Copilot <TAB> completion
            -- ['<Tab>'] = vim.schedule_wrap(function(fallback)
            --  if cmp.visible() and has_words_before() then
            --    cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
            --  else
            --    fallback()
            --  end
            -- end),

            -- Select the [n]ext item
            ['<C-n>'] = cmp.mapping.select_next_item(),
            -- Select the [p]revious item
            ['<C-p>'] = cmp.mapping.select_prev_item(),

            -- Accept ([y]es) the completion.
            --  This will auto-import if your LSP supports it.
            --  This will expand snippets if the LSP sent a snippet.
            ['<C-y>'] = cmp.mapping.confirm({ select = true }),

            -- Manually trigger a completion from nvim-cmp.
            --  Generally you don't need this, because nvim-cmp will display
            --  completions whenever it has completion options available.
            ['<C-Space>'] = cmp.mapping.complete({}),

            -- <c-l> will move you to the right of each of the expansion locations.
            -- <c-h> is similar, except moving you backwards.
            ['<C-l>'] = cmp.mapping(function()
              if luasnip.expand_or_locally_jumpable() then
                luasnip.expand_or_jump()
              end
            end, { 'i', 's' }),
            ['<C-h>'] = cmp.mapping(function()
              if luasnip.locally_jumpable(-1) then
                luasnip.jump(-1)
              end
            end, { 'i', 's' }),
          }),
          sorting = {
            priority_weight = 2,
            comparators = {
              require('copilot_cmp.comparators').prioritize,

              -- Default nvim-cmp comparitors
              cmp.config.compare.offset,
              -- cmp.config.compare.scopes,
              cmp.config.compare.exact,
              cmp.config.compare.score,
              cmp.config.compare.recently_used,
              cmp.config.compare.locality,
              cmp.config.compare.kind,
              cmp.config.compare.sort_text,
              cmp.config.compare.length,
              cmp.config.compare.order,
            },
          },
          sources = {
            { name = 'copilot', group_index = 2 },
            { name = 'nvim_lsp', group_index = 2 },
            { name = 'luasnip', group_index = 2 },
            { name = 'path', group_index = 2 },
          },
        })
      end,
    },

    -- Useful status updates for LSPs
    { 'j-hui/fidget.nvim', opts = {} },
  },
  config = function()
    vim.diagnostic.config({
      float = {
        border = 'rounded',
        focusable = true,
      },
    })

    vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
      border = 'rounded',
      focusable = true,
    })

    vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
      border = 'rounded',
      focusable = true,
    })

    -- This function runs when an LSP attaches to a particular buffer
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
      callback = function(event)
        -- Function that more easily defines mappings specific for LSP related items
        -- It sets the mode, buffer, and description
        local map = function(keys, func, desc)
          vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
        end

        -- Jump to the definition of the word under your cursor
        --  This is where a variable was first declared, or where a function is defined, etc.
        --  To jump back, press <C-T>.
        map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

        -- Find references for the word under your cursor
        map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

        -- Jump to the implementation of the word under your cursor
        --  Useful when your language has ways of declaring types without an actual implementation
        map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

        -- Jump to the type of the word under your cursor.
        --  Useful when you're not sure what type a variable is and you want to see
        --  the definition of its *type*, not where it was *defined*.
        map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')

        -- Fuzzy find all the symbols in your current document
        --  Symbols are things like variables, functions, types, etc.
        map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')

        -- Fuzzy find all the symbols in your current workspace
        --  Similar to document symbols, except searches over your whole project.
        map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

        -- Rename the variable under your cursor
        --  Most Language Servers support renaming across files, etc.
        map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

        -- Execute a code action, usually your cursor needs to be on top of an error
        -- or a suggestion from your LSP for this to activate.
        map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

        -- Opens a popup that displays documentation about the word under your cursor
        --  See `:help K` for why this keymap
        map('K', vim.lsp.buf.hover, 'Hover Documentation')

        -- WARN: This is not Goto Definition, this is Goto Declaration
        map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

        -- Autocommands that are used to highlight references of the word under your cursor rests for a little while
        --  When the cursor moves, the highlights will be cleared (2nd autocommand)
        -- NOTE: See `:help CursorHold` and `:help CursorMoved` for information about when this is executed
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client.server_capabilities.documentHighlightProvider then
          vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            buffer = event.buf,
            callback = vim.lsp.buf.document_highlight,
          })

          vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            buffer = event.buf,
            callback = vim.lsp.buf.clear_references,
          })
        end
      end,
    })

    -- Extend Neovim's LSP capabilities via nvim-cmp, luasnip, etc.
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

    -- Enable the following language servers
    local servers = {
      -- apex_ls = {},
      clangd = {},
      cmake = {},
      csharp_ls = {},
      -- html = {},
      lua_ls = {
        settings = {
          Lua = {
            runtime = { version = 'LuaJit' },
            workspace = {
              checkThirdParty = false,
              library = {
                vim.env.VIMRUNTIME,
                '${3rd}/luv/library',
                -- unpack(vim.api.nvim_get_runtime_file('', true)),
              },
              completion = {
                callSnippet = 'Replace',
              },
              -- diagnostics = { disable = { 'missing-fields' } },
            },
          },
        },
      },
      pyright = {},
      -- racket_langserver = {},
      rust_analyzer = {},
    }

    require('mason').setup({
      log_level = vim.log.levels.DEBUG,
      ui = {
        border = 'rounded',
        icons = {
          package_installed = '✓',
          package_pending = '➜',
          package_uninstalled = '✗',
        },
      },
    })

    local ensure_installed = vim.tbl_keys(servers or {})
    vim.list_extend(ensure_installed, {
      'stylua', -- Used to format lua code
    })
    require('mason-tool-installer').setup({ ensure_installed = ensure_installed })

    require('mason-lspconfig').setup({
      handlers = {
        function(server_name)
          local server = servers[server_name] or {}
          server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
          require('lspconfig')[server_name].setup(server)
        end,
      },
    })
  end,
}
