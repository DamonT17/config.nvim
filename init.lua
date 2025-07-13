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
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system({ 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
      { out, 'WarningMsg' },
      { '\nPress any key to exit...' },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- [[ Setting leader key ]]
-- NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
-- Set <space> as the leader key
-- See `:help mapleader`
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- [[ Setting options, keymaps, commands ]]
require('custom.options')
require('custom.keymaps')
require('custom.commands')

-- [[ Configure and install plugins ]]
require('lazy').setup('custom.plugins', {
  checker = {
    enabled = true,
    notify = true,
  },
  ui = {
    border = 'rounded',
    title = ' Lazy Plugin Manager ',
    title_pos = 'center',
  },
})
