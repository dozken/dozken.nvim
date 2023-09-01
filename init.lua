-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
-- unbind <C-e> from line scroll for 'harpoon'
vim.api.nvim_set_keymap('n', '<C-e>', '', {})
-- vim.keymap.del('n', '<C-e>')
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

-- NOTE: Here is where you install your plugins.
--  You can configure plugins using the `config` key.
--
--  You can also configure plugins after the setup call,
--    as they will be available in your neovim runtime.
require('lazy').setup({
  spec = {
    {
      "folke/tokyonight.nvim",
      lazy = false,
      priority = 1000,
      opts = {},
      config = function()
        vim.cmd.colorscheme 'tokyonight-moon'
      end,
    },

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

    { 'folke/which-key.nvim', event = 'VeryLazy', opts = {} },

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
      enabled = false,
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




    -- Fuzzy Finder (files, lsp, etc)


    -- NOTE: Next Step on Your Neovim Journey: Add/Configure additional "plugins" for kickstart
    --       These are some example plugins that I've included in the kickstart repository.
    --       Uncomment any of the lines below to enable them.
    -- require 'kickstart.plugins.autoformat',
    -- require 'kickstart.plugins.debug',

    { import = "plugins" },
  },
  install = { colorscheme = { "tokyonight", "habamax" } },
  checker = { enabled = true }, -- automatically check for plugin updates
  performance = {
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
}, {})

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
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.keymap.set('n', '<leader>l', '<cmd>Lazy<cr>', { silent = true })
-- vim.keymap.set("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit all" })


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



-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
-- require('nvim-treesitter.configs').setup

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- [[ Configure LSP ]]
--  This function gets run when an LSP connects to a particular buffer.

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
--
--  If you want to override the default filetypes that your language server will attach to you can
--  define the property 'filetypes' to the map in question.
-- local servers = {
--   -- clangd = {},
--   -- gopls = {},
--   -- pyright = {},
--   -- rust_analyzer = {},
--   tsserver = {},
--   -- html = { filetypes = { 'html', 'twig', 'hbs'} },
--
--   lua_ls = {
--     Lua = {
--       workspace = { checkThirdParty = false },
--       telemetry = { enable = false },
--     },
--   },
-- }

-- Setup neovim lua configuration

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Ensure the servers above are installed
-- local mason_lspconfig = require 'mason-lspconfig'
--
-- mason_lspconfig.setup {
--   ensure_installed = vim.tbl_keys(servers),
-- }
--
-- mason_lspconfig.setup_handlers {
--   function(server_name)
--     local on_attach = function(_, bufnr)
--       -- NOTE: Remember that lua is a real programming language, and as such it is possible
--       -- to define small helper and utility functions so you don't have to repeat yourself
--       -- many times.
--       --
--       -- In this case, we create a function that lets us more easily define mappings specific
--       -- for LSP related items. It sets the mode, buffer and description for us each time.
--       local nmap = function(keys, func, desc)
--         if desc then
--           desc = 'LSP: ' .. desc
--         end
--
--         vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
--       end
--
--       nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
--       nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
--
--       nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
--       nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
--       nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
--       nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
--       nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
--       nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
--
--       -- See `:help K` for why this keymap
--       nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
--       nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')
--
--       -- Lesser used LSP functionality
--       nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
--       nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
--       nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
--       nmap('<leader>wl', function()
--         print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
--       end, '[W]orkspace [L]ist Folders')
--
--       -- Create a command `:Format` local to the LSP buffer
--       vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
--         vim.lsp.buf.format()
--       end, { desc = 'Format current buffer with LSP' })
--     end
--
--
--     local capabilities = vim.lsp.protocol.make_client_capabilities()
--     capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
--     require('lspconfig')[server_name].setup {
--       capabilities = capabilities,
--       on_attach = on_attach,
--       settings = servers[server_name],
--       filetypes = (servers[server_name] or {}).filetypes,
--     }
--   end,
-- }


-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
