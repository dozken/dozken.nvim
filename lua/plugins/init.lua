return {
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

        -- { "nvim-tree/nvim-web-devicons", lazy = true },

        -- fun
        {
                'eandrju/cellular-automaton.nvim',
                keys = {
                        { '<leader>mr',  '<cmd>CellularAutomaton make_it_rain<cr>', desc = 'Make It Rain' },
                        { '<leader>gol', '<cmd>CellularAutomaton game_of_life<cr>', desc = 'Make It Rain' }
                }
        },
        -- "nvim-lua/plenary.nvim", -- lua functions that many plugins use

        { "christoomey/vim-tmux-navigator", event = 'VeryLazy' },         -- tmux & split window navigation
}
