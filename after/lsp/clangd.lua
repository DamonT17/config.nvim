--- Configure the clangd language server for C/C++ development
return {
  cmd = { 'clangd', '--background-index', '--clang-tidy' },
  init_options = {
    fallbackFlags = { '-std=c++20' },
  },
}
