vim.lsp.config('csharp_ls', {
  cmd = { vim.fn.expand('~/.dotnet/tools/csharp-ls') },
})

vim.lsp.enable('csharp_ls')
