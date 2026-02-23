--- Neovim standard options

-- [[ Setting options ]]
-- NOTE: For more options, you can see `:help option-list`
-- See `:help vim.opt`
vim.opt.showmode = true -- Show the active mode
vim.opt.cursorline = true -- Highlight the current line
vim.opt.guicursor = 'n-v-c-sm:block,i-ci-ve:block-blinkwait700-blinkoff400-blinkon250,r-cr-o:hor20' -- Cursor styling
vim.opt.number = true -- Show number lines
vim.opt.relativenumber = true -- Show relative number line
vim.opt.scrolloff = 10 -- Minimal number of lines to keep above/below the cursor
vim.opt.inccommand = 'split' -- Preview substitutions as you type
vim.opt.hlsearch = true -- Set highlight on search, clear on pressing <Esc> in normal mode
vim.opt.clipboard = 'unnamedplus' -- Sync clipboard between OS and Neovim
vim.opt.history = 500 -- Remember n lines in history
vim.opt.lazyredraw = true -- Don't redraw while executing macro
vim.opt.signcolumn = 'yes:1' -- Keep signcolumn on by defaults
vim.opt.colorcolumn = '121' -- Show a column at 121 characters
vim.opt.completeopt = { 'menu', 'menuone', 'noselect', 'noinsert', 'preview' } -- Completion options

-- Indentation
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.breakindent = true -- Wrapped lines will continue visually indented

vim.opt.ignorecase = true -- Case-insensitive searching
vim.opt.smartcase = true -- Override 'ignorecase' if \C or capital in search

vim.opt.wildmode = 'list:longest,list:full' -- Command-line completion mode

vim.opt.list = true -- Display of whitespace in the editor
vim.opt.listchars = { eol = '↲', tab = '» ', trail = '·', nbsp = '␣' }

vim.opt.timeoutlen = 300 -- Time to wait for a mapped sequence to complete
vim.opt.updatetime = 500 -- Faster completion
vim.opt.undofile = true -- Save undo history

-- Popup menu options
vim.opt.pumheight = 10 -- Maximum number of items in the popup menu

-- Split configuration on opening
vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.mouse = 'a' -- Enable mouse support

vim.opt.winborder = 'rounded' -- Set window border style

-- Folding configuration
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.opt.foldlevelstart = 99
vim.opt.foldcolumn = 'auto'
vim.opt.fillchars = {
  fold = ' ',
  foldopen = '',
  foldsep = ' ',
  foldclose = '',
}
