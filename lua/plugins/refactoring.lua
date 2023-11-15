return {
  {
    "ThePrimeagen/refactoring.nvim",
    lazy = true,
    event = { "BufReadPost", "BufNewFile" },
    keys = {
      {
        '<leader>rr',
        '<CMD>lua require("telescope").extensions.refactoring.refactors()<CR>',
        mode = { 'n', 'x' },
        desc = "Refactoring"
      },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      {
        "nvim-telescope/telescope.nvim",
        lazy = true,
        config = function()
          require("telescope").load_extension("refactoring")
        end
      },
    },
  }
}
