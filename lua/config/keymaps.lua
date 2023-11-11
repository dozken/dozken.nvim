-- Set <space> as the leader key
-- See `:help mapleader`
-- NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- [[ Basic Keymaps ]]
-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.keymap.set('n', '<leader>l', '<cmd>Lazy<cr>', { desc = '[L]azy Home' })

vim.keymap.set("i", "<C-c>", "<Esc>", { desc = 'Exit insert mode' })

vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = 'Scroll & center down' })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = 'Scroll & center up' })

vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = '[Y]ank to clipboard' })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = '[Y]ank line to clipboard' })
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = 'Replace with clipboard' })
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = '[D]elete to void' })

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, { desc = '[F]ormat buffer' })

-- Remap k and j in normal mode to handle word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
--
-- Diagnostic keymaps
-- Map keys to navigate and manage diagnostics
-- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
-- vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
-- vim.keymap.set('n', '<leader>E', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
-- vim.keymap.set('n', '<leader>Q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })
-- vim.keymap.set('n', '<C-k>', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
-- vim.keymap.set('n', '<C-j>', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
-- vim.keymap.set('n', '<leader>k', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
-- vim.keymap.set('n', '<leader>j', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
