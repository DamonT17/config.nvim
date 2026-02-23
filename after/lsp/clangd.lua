--- Configure the clangd language server for C/C++ development
vim.lsp.config('clangd', {
  cmd = { 'clangd', '--background-index', '--clang-tidy', '--log=verbose' },
  init_options = {
    fallbackFlags = { '-std=c++20' },
  },
})

-- require('mason').setup()
-- require('mason-lspconfig').setup()
