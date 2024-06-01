return {
    -- lazy.nvim
    {
        "m4xshen/hardtime.nvim",
        enabled = false,
        event = { "BufRead", "BufNewFile" },
        dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },

        keys = {
            { "<leader>zh", "<cmd>Hardtime toggle<cr>", desc = "HardTime Toggle" },
        },
        opts = {}
    },


    {
        "tris203/precognition.nvim",
        enabled = false,
        event = { "BufRead", "BufNewFile" },
        keys = function()
            local prec = require("precognition")
            return {
                { "<leader>zp", function() prec.toggle() end, desc = "Precognition Toggle" },
            }
        end,

        config = {
            -- startVisible = true,
            -- showBlankVirtLine = true,
            -- hints = {
            --      Caret = { text = "^", prio = 2 },
            --      Dollar = { text = "$", prio = 1 },
            --      MatchingPair = { text = "%", prio = 5 },
            --      Zero = { text = "0", prio = 1 },
            --      w = { text = "w", prio = 10 },
            --      b = { text = "b", prio = 9 },
            --      e = { text = "e", prio = 8 },
            --      W = { text = "W", prio = 7 },
            --      B = { text = "B", prio = 6 },
            --      E = { text = "E", prio = 5 },
            -- },
            -- gutterHints = {
            --     -- prio is not currently used for gutter hints
            --     G = { text = "G", prio = 1 },
            --     gg = { text = "gg", prio = 1 },
            --     PrevParagraph = { text = "{", prio = 1 },
            --     NextParagraph = { text = "}", prio = 1 },
            -- },
        },
    },

    {
        "windwp/nvim-ts-autotag",
        event = { "BufRead", "BufNewFile" },
        config = function()
            require('nvim-ts-autotag').setup({
                opts = {
                    -- Defaults
                    enable_close = true,          -- Auto close tags
                    enable_rename = true,         -- Auto rename pairs of tags
                    enable_close_on_slash = false -- Auto close on trailing </
                },
                -- Also override individual filetype configs, these take priority.
                -- Empty by default, useful if one of the "opts" global settings
                -- doesn't work well in a specific filetype
                per_filetype = {
                    ["html"] = {
                        enable_close = false
                    }
                }
            })
        end
    },
    {
        'windwp/nvim-autopairs',
        event = 'InsertEnter',
        -- Optional dependency
        dependencies = { 'hrsh7th/nvim-cmp' },
        config = function()
            require('nvim-autopairs').setup {}
            -- If you want to automatically add `(` after selecting a function or method
            local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
            local cmp = require 'cmp'
            cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
        end,
    }
}
