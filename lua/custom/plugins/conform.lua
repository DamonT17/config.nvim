return {
  -- [[ Plugin: stevearc/conform.nvim ]]
  -- NOTE: See `:help conform.txt` or https://github.com/stevearc/conform.nvim for more info
  -- Run `:ConformInfo` to view configured and available formatters, as well as to see the log file
  'stevearc/conform.nvim',
  opts = {
    notify_on_error = false,
    format_on_save = {
      timeout_ms = 500,
      lsp_format = 'fallback',
    },
    formatters_by_ft = {
      apex = { 'prettier' },
      cmake = { 'cmake_format' },
      csharp = { 'csharpier' },
      css = { 'prettier' },
      cpp = { 'clang-format' },
      html = { 'prettier' },
      javascript = { 'biome' },
      json = { 'biome' },
      lua = { 'stylua' },
      python = { 'darker', 'black' },
      yaml = { 'prettier' },
      ['*'] = { 'codespell' }, -- Formatter for all filetypes
      ['_'] = { 'trim_whitespace', 'trim_newlines', 'squeeze_blanks' }, -- Formatter(s) on filetypes w/o a formatter
    },
  },
}
