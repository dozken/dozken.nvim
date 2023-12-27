return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        opts = {
            color_overrides = {
                all = {
                    base = "#111000",
                },
            },
            styles = {                   -- Handles the styles of general hi groups (see `:h highlight-args`):
                comments = { "italic" }, -- Change the style of comments
            },
            transparent_background = true,

            intergrations = {
                treesitter = true,
                treesitter_context = false,
                mason = true,
                cmp = false,
                harpoon = true,
                fidget = true,
                telescope = true,
                mini = {
                    enabled = true,
                    indentscope_color = "",
                },

            },
            highlight_overrides = {
                all = function(colors)
                    return {
                        NvimTreeNormal = { fg = colors.none },
                        CmpBorder = { fg = "#3e4145", bg = "#ff00ff" },
                    }
                end,
            },
        },
        config = function(_, opts)
            require('catppuccin').setup(opts)
            vim.cmd.colorscheme 'catppuccin-mocha'
        end,
        dependencies = {
            {
                'nvim-lualine/lualine.nvim',
                event = 'ColorScheme',
                config = function(_, opts)
                    opts.options.theme = 'catppuccin-mocha'
                    require('lualine').setup(opts)
                end
            }
        }
    },

    {
        'folke/tokyonight.nvim',
        lazy = true,
        opts = { style = 'night' },
        config = function()
            vim.cmd.colorscheme 'tokyonight-night'
        end,
        dependencies = {
            {
                'nvim-lualine/lualine.nvim',
                lazy = true,
                event = 'ColorScheme',
                config = function(_, opts)
                    opts.options.theme = 'tokyonight'
                    require('lualine').setup(opts)
                end
            }
        }
    },


    {
        'rose-pine/neovim',
        lazy = true,
        name = 'rose-pine',
        opts = {
            groups = {
                background = "#111000"
            }
        },
        config = function(_, opts)
            require('rose-pine').setup(opts)
            vim.cmd.colorscheme 'rose-pine'
        end,
        dependencies = {
            {
                'nvim-lualine/lualine.nvim',
                lazy = true,
                event = 'ColorScheme',
                event = 'ColorScheme',
                config = function(_, opts)
                    opts.options.theme = 'rose-pine'
                    require('lualine').setup(opts)
                end
            }
        }

    },

}
