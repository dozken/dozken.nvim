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
                        opts = {},
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
                        config = function()
                                require("indent_blankline").setup {
                                        buftype_exclude = { "terminal", "nofile" },
                                        filetype_exclude = { "dashboard", "mason" },
                                }
                        end,
                },

                -- "gc" to comment visual regions/lines
                {
                        'echasnovski/mini.comment',
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
