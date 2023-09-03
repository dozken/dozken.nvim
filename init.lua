-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
-- unbind <C-e> from line scroll for 'harpoon'
vim.api.nvim_set_keymap('n', '<C-e>', '', {})

-- Install package manager
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  spec = {
    {
      'folke/tokyonight.nvim',
      lazy = false,
      priority = 1000,
      opts = { style = 'moon' },
      config = function()
        vim.cmd.colorscheme 'tokyonight-moon'
      end,
    },
    -- {
    --   'morhetz/gruvbox',
    --   lazy = false,
    --   priority = 1000,
    --   config = function()
    --     vim.cmd.colorscheme 'gruvbox'
    --   end
    -- },

    {
      -- Set lualine as statusline
      'nvim-lualine/lualine.nvim',
      event = "VeryLazy",
      opts = {
        options = {
          icons_enabled = false,
          theme = 'auto',
          component_separators = '|',
          section_separators = '',
        },
      },
    },

    { 'folke/which-key.nvim', event = 'VeryLazy',                                                 opts = {} },
    { 'folke/zen-mode.nvim',  keys = { { '<leader>zz', '<cmd>ZenMode<cr>', desc = 'Zen Mode' } }, opts = {} },

    {
      -- Add indentation guides even on blank lines
      'lukas-reineke/indent-blankline.nvim',
      event = { "BufReadPost", "BufNewFile" },
      opts = {
        char = '┊',
        show_trailing_blankline_indent = false,
      },
    },

    -- "gc" to comment visual regions/lines
    {
      'numToStr/Comment.nvim',
      event = { "BufReadPost", "BufNewFile" },
      opts = {}
    },

    -- Git related plugins
    {
      'kdheepak/lazygit.nvim',
      keys = {
        { '<leader>gg', '<cmd>LazyGit<cr>', desc = 'LazyGit' },
      },
      cmd = 'LazyGit',
      --   -- optional for floating window border decoration
      dependencies = {
        'nvim-lua/plenary.nvim',
      },
    },
    {
      'tpope/vim-fugitive',
      cmd = 'Git'
    },
    -- 'tpope/vim-rhubarb',
    -- Detect tabstop and shiftwidth automatically
    -- 'tpope/vim-sleuth',
    {
      -- Adds git related signs to the gutter, as well as utilities for managing changes
      'lewis6991/gitsigns.nvim',
      event = { 'BufReadPost', 'BufNewFile' },
      opts = {
        -- See `:help gitsigns.txt`
        signs = {
          add = { text = '+' },
          change = { text = '~' },
          delete = { text = '_' },
          topdelete = { text = '‾' },
          changedelete = { text = '~' },
        },
        on_attach = function(bufnr)
          vim.keymap.set('n', '<leader>gp', require('gitsigns').prev_hunk,
            { buffer = bufnr, desc = '[G]o to [P]revious Hunk' })
          vim.keymap.set('n', '<leader>gn', require('gitsigns').next_hunk,
            { buffer = bufnr, desc = '[G]o to [N]ext Hunk' })
          vim.keymap.set('n', '<leader>ph', require('gitsigns').preview_hunk,
            { buffer = bufnr, desc = '[P]review [H]unk' })
        end,
      },
    },

    { 'mbbill/undotree', keys = { { '<leader>u', '<cmd>UndotreeToggle<cr>', mode = 'n', desc = 'Undotree' } } },

    -- fun
    {
      'eandrju/cellular-automaton.nvim',
      keys = {
        { '<leader>mr',  '<cmd>CellularAutomaton make_it_rain<cr>', desc = 'Make It Rain' },
        { '<leader>gol', '<cmd>CellularAutomaton game_of_life<cr>', desc = 'Make It Rain' }
      }
    },

    { import = "plugins" },
  },
  install = { colorscheme = { "tokyonight" } },
  checker = { enabled = true }, -- automatically check for plugin updates
  performance = {
    cache = {
      enabled = true,
    },
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})

-- [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!

-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default
vim.wo.number = true
vim.wo.relativenumber = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = 'unnamedplus'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 200
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.guicursor = ""


-- [[ Basic Keymaps ]]
-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.keymap.set('n', '<leader>l', '<cmd>Lazy<cr>', { desc = 'Lazy' })
-- vim.keymap.set("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit all" })
vim.keymap.set("i", "<C-c>", "<Esc>", { desc = 'Exit insert mode' })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = 'Scroll & center down' })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = 'Scroll & center up' })
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = 'Copy to clipboard' })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = 'Copy line to clipboard' })
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = 'Replace with clipboard' })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
