-- Set <space> as the leader key
-- See `:help mapleader`
-- NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- [[ Basic Keymaps ]]
-- Keymaps for better default experience
-- See `:help vim.keymap.set()`

-- Disable Space key in normal and visual modes (acts as a placeholder)
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Map <leader>l in normal mode to the ':Lazy' command
vim.keymap.set('n', '<leader>l', '<cmd>Lazy<cr>', { desc = 'Lazy' })

-- Map <C-c> in insert mode to exit insert mode
vim.keymap.set("i", "<C-c>", "<Esc>", { desc = 'Exit insert mode' })

-- Map <C-d> in normal mode to scroll down and center the screen
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = 'Scroll & center down' })

-- Map <C-u> in normal mode to scroll up and center the screen
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = 'Scroll & center up' })

-- Copy to clipboard using <leader>y in normal and visual modes
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = 'Copy to clipboard' })

-- Copy the current line to clipboard using <leader>Y in normal mode
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = 'Copy line to clipboard' })

-- Replace selected text with clipboard content using <leader>p in visual mode
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = 'Replace with clipboard' })

-- Execute Ex commands using <leader>pv in normal mode
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "Ex" })

-- Remap k and j in normal mode to handle word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
-- Map keys to navigate and manage diagnostics
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>E', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>Q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })
