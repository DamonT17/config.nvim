return {
  -- [[ Plugin: catppuccin/nvim colorscheme 'mocha' ]]
  -- NOTE: See `:help catppuccin.txt` or https://github.com/catppuccin/nvim for more info
  'catppuccin/nvim',
  name = 'catppuccin',
  lazy = false,
  priority = 1000,
  config = function()
    require('catppuccin').setup({
      flavour = 'mocha',
      background = {
        light = 'latte',
        dark = 'mocha',
      },
      dim_inactive = {
        enabled = true,
        shade = 'dark',
        percentage = 0.15,
      },
      integrations = {
        cmp = true,
        fidget = true,
        gitsigns = true,
        harpoon = false,
        mason = false,
        native_lsp = {
          enabled = true,
          virtual_text = {
            errors = { 'italic' },
            hints = { 'italic' },
            warnings = { 'italic' },
            information = { 'italic' },
          },
          underlines = {
            errors = { 'underline' },
            hints = { 'underline' },
            warnings = { 'underline' },
            information = { 'underline' },
          },
          inlay_hints = {
            background = true,
          },
        },
        treesitter = true,
        telescope = {
          enabled = true,
        },
        which_key = false,
      },
    })

    -- Setup must be called before loading
    vim.cmd.colorscheme('catppuccin')
  end,
}
