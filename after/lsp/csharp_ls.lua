--- Configure csharp_ls for C# development
return {
  cmd = { vim.fn.expand('~/.dotnet/tools/csharp-ls') },
}
