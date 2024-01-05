return {
    "ThePrimeagen/refactoring.nvim",
    -- event = { "BufReadPost", "BufNewFile" },
    cmd = "Refactor",
    keys = {
        {
            '<leader>rr',
            '<CMD>lua require("telescope").extensions.refactoring.refactors()<CR>',
            mode = { 'n', 'x' },
            desc = "Refactoring"
        },
        {
            '<leader>ri',
            [[ <Esc><Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]],
            mode = { 'v' },
            { noremap = true, silent = true, expr = false, desc = "Refactoring" }
        },
        { "<leader>re",  ":Refactor extract ",              mode = "x" },
        { "<leader>rf",  ":Refactor extract_to_file ",      mode = "x" },
        { "<leader>rv",  ":Refactor extract_var ",          mode = "x" },
        { "<leader>ri",  ":Refactor inline_var",            mode = { "n", "x" } },
        { "<leader>rI",  ":Refactor inline_func",           mode = "n" },
        { "<leader>rb",  ":Refactor extract_block",         mode = "n" },
        { "<leader>rbf", ":Refactor extract_block_to_file", mode = "n" },

    },
    dependencies = {
        "nvim-telescope/telescope.nvim",
    },
    config = function()
        require("telescope").load_extension("refactoring")
    end
}
