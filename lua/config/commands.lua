--- Neovim custom commands

-- [[ Basic Autocommands ]]
-- NOTE: See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
-- NOTE: See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- LSP attach autocommand
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
  callback = function(event)
    -- Function that more easily defines mappings specific for LSP related items
    local map = function(keys, func, desc)
      vim.keymap.set('n', keys, func, { buffer = event.buf, desc = desc })
    end

    map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
    map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
    map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
    map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
    map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
    map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
    map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
    map('<leader>rn', vim.lsp.buf.rename, 'Rename variable')
    map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
    map('<leader>cs', function()
      vim.lsp.buf.signature_help({ border = 'rounded', focusable = true })
    end, '[Code] [S]ignature Help')
    map('K', function()
      --- Opens a popop that displays documentation about the word under the cursor
      vim.lsp.buf.hover({ border = 'rounded', focusable = true })
    end, 'Hover Documentation')

    -- Autocommands that are used to highlight references of the word under your cursor rests for a little while
    --  When the cursor moves, the highlights will be cleared (2nd autocommand)
    -- NOTE: See `:help CursorHold` and `:help CursorMoved` for information about when this is executed
    local client = vim.lsp.get_clients({ id = event.data.client_id })[1]
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
