-- [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!

-- vim.opt.guicursor = ""

-- Enable auto write
vim.opt.autowrite = true
vim.opt.confirm = true
-- Set highlight on search
vim.o.hlsearch = true

-- Make line numbers default
vim.wo.number = true
vim.wo.relativenumber = true

-- Enable mouse mode
vim.o.mouse = "a"
-- Enable auto write
vim.o.autowrite = true

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help "clipboard"`
vim.o.clipboard = "unnamedplus"

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.cursorline = true -- highlight the current cursor line

-- Keep signcolumn on by default
vim.wo.signcolumn = "yes"

-- Decrease update time
vim.o.updatetime = 200
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noselect"

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true
vim.o.showmode = false

-- tabs & indentation
vim.o.tabstop = 4        -- 2 spaces for tabs (prettier default)
vim.o.shiftwidth = 4     -- 2 spaces for indent width
vim.o.expandtab = true   -- expand tab to spaces
vim.o.autoindent = true  -- copy indent from current line when starting new one
vim.o.smartindent = true -- Insert indents automaticall                                    y
vim.api.nvim_win_set_option(0, 'colorcolumn', '81')
vim.cmd([[highlight ColorColumn ctermbg=NONE guibg=NONE]])
vim.cmd([[match ColorColumn /\%>81v.\+/]])


-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0

-- vim.opt.splitkeep = "sceen"
-- vim.opt.shortmess:append({ C = true })
