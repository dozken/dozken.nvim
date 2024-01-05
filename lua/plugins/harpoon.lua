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
    config = function()
        require("telescope").load_extension("harpoon")
    end,
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim",
    },
}
