--- Neovim configuration entry point. Inspirations taken from the kickstart.nvim project among other sources.

--[[ Helpful references while getting started with Neovim 
  - Getting started
    :Tutor
  - Help
    :help (keymap `<space>sh` available to [s]earch the [h]elp documentation)
  - Troubleshooting
    :checkhealth
  - Lua 
    https://learnxinyminutes.com/docs/lua/
    :help lua-guide (https://neovim.io/doc/user/lua-guide.html)
--]]

-- [[ Bootstrap `lazy.nvim` plugin manager ]]
-- NOTE: See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system({ 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath })
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- [[ Setting leader key ]]
-- NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
-- Set <space> as the leader key
-- See `:help mapleader`
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- [[ Setting options, keymaps, commands ]]
require('dalux.options')
require('dalux.keymaps')
require('dalux.commands')

-- [[ Configure and install plugins ]]
require('lazy').setup('dalux.plugins', {
  change_detection = {
    notify = false,
  },
  ui = {
    border = 'rounded',
    title = ' Lazy Plugin Manager ',
    title_pos = 'center',
  },
})
