return {
  -- [[ Plugin: stevearc/conform.nvim ]]
  -- NOTE: See `:help conform.txt` or https://github.com/stevearc/conform.nvim for more info
  'stevearc/conform.nvim',
  opts = {
    notify_on_error = false,
    format_on_save = {
      timeout_ms = 500,
      lsp_fallback = true,
    },
    formatters_by_ft = {
      lua = { 'stylua' },
      -- Add additional formatters here!
    },
  },
}
