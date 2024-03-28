-- Highlight todo, notes, etc in comments
return {
  'folke/todo-comments.nvim',
  event = 'VimEnter',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local todo = require('todo-comments')
    todo.setup({
      signs = true,
    })

    -- [[ Todo Comments keymaps ]]
    local wk = require('which-key')
    wk.register({
      ['[t'] = {
        function()
          todo.jump_prev()
        end,
        'Previous [T]odo Comment',
      },
      [']t'] = {
        function()
          todo.jump_next()
        end,
        'Next [T]odo Comment',
      },
    }, { mode = 'n' })
  end,
}
