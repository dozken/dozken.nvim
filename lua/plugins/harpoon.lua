return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    keys = function()
        local harpoon = require("harpoon")
        return {
            { "<C-e>",      function() harpoon.ui:toggle_quick_menu(harpoon:list()) end },
            { "<A-h>",      function() harpoon:list():select(1) end },
            { "<A-j>",      function() harpoon:list():select(2) end },
            { "<A-k>",      function() harpoon:list():select(3) end },
            { "<A-l>",      function() harpoon:list():select(3) end },
            { "<leader>ha", function() harpoon:list():append() end,                     desc = "Harpoon Add file" },
            { "<leader>hp", function() harpoon:list():next() end,                       desc = "Harpoon Prev" },
            { "<leader>hn", function() harpoon:list():prev() end,                       desc = "Harpoon Next" },
            { "<leader>hm", '<cmd>Telescope harpoon marks<cr>',                         desc = "Harpoon Marks" },
        }
    end,
    opts = {},
    config = function()
        local harpoon = require("harpoon")
        harpoon:setup({
            settings = {
                save_on_toggle = false,
                sync_on_ui_close = false,
                key = function()
                    return vim.loop.cwd()
                end,
            },
        })
        local highlights = {
            HarpoonWindow = { default = true, link = "NormalFloat" },
            HarpoonBorder = { default = true, link = "FloatBorder" },
            HarpoonTitle = { default = true, link = "FloatTitle" },
        }
        for k, v in pairs(highlights) do
            vim.api.nvim_set_hl(0, k, v)
        end
    end,

    dependencies = {
        "nvim-lua/plenary.nvim",
        {
            "nvim-telescope/telescope.nvim",
            config = function()
                require("telescope").load_extension("harpoon")
            end,
        },
    },
}
