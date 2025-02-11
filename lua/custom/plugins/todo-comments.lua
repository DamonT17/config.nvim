return {
  -- [[ Plugin: folke/todo-comments.nvim ]]
  -- NOTE: See `todo-comments.nvim.txt` or https://github.com/folke/todo-comments.nvim for more info
  -- Allows for the highlighting of various comment types in buffers. The currently enabled comment types are:
  -- PERF: Performance related comments
  -- HACK: Hacky related comments
  -- TODO: Todo related comments
  -- NOTE: Note related comments
  -- WARN: Warning related comments
  -- TEST: Test related comments
  -- FIX: Bugfix related comments
  'folke/todo-comments.nvim',
  event = 'VimEnter',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local todo = require('todo-comments')
    todo.setup({
      signs = true,
      colors = {
        error = { 'DiagnosticError', 'ErrorMsg', '#F38BA8' },
        warning = { 'DiagnosticWarn', 'WarningMsg', '#FAB387' },
        info = { 'DiagnosticInfo', '#CBA6F7' },
        hint = { 'DiagnosticHint', '#94E2D5' },
        default = { 'Identifier', '#F5C2E7' },
        test = { 'Identifier', '#F9E2AF' },
      },
    })

    -- [[ Keymaps ]]
    vim.keymap.set('n', '[t', function()
      todo.jump_prev()
    end, { desc = 'Previous [T]odo Comment' })
    vim.keymap.set('n', ']t', function()
      todo.jump_next()
    end, { desc = 'Next [T]odo Comment' })
  end,
}
