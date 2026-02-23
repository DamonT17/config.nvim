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

-- [[ Plugin Manager (lazy.nvim) configuration ]]
require('config.lazy')

-- [[ Custom snippets ]]
require('luasnip.loaders.from_lua').lazy_load({ paths = '~/.config/nvim/lua/snippets/' })
