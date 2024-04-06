return {
  -- [[ Plugin: nvim-treesitter ]]
  -- NOTE: See `:help treesitter.txt`, `:help nvim-treesitter` or https://github.com/nvim-treesitter/nvim-treesitter for more info
  -- To inspect a buffer's treesitter syntax, the following commands can be used:
  --  `:Inspect`
  --  `:InspectTree`
  --  `:EditQuery`
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  config = function()
    ---@diagnostic disable-next-line: missing-fields
    require('nvim-treesitter.configs').setup({
      ensure_installed = {
        'apex',
        'bash',
        'c',
        'cpp',
        'c_sharp',
        'cmake',
        'html',
        'lua',
        'markdown',
        'python',
        'vim',
        'vimdoc',
      },
      auto_install = true,
      highlight = {
        enable = true,
        custom_captures = {
          -- Highlight comment documentation
          ['comment.documentation'] = 'Identifier',
        },
      },
      indent = { enable = true },
    })
  end,
}
