return {
  "ThePrimeagen/harpoon",
  events = "VeryLazy",
  keys = {
    { "<leader>hm", '<cmd>Telescope harpoon marks<cr>',                      desc = "Harpoon Marks" },
    { "<C-e>",      '<cmd>lua require("harpoon.ui").toggle_quick_menu()<cr>' },
    { "<leader>ha", '<cmd>lua require("harpoon.mark").add_file()<cr>',       desc = "Harpoon Add file" },
    { "<A-h>",      '<cmd>lua require("harpoon.ui").nav_file(1)<cr>',        desc = "Harpoon 1" },
    { "<A-j>",      '<cmd>lua require("harpoon.ui").nav_file(2)<cr>',        desc = "Harpoon 2" },
    { "<A-k>",      '<cmd>lua require("harpoon.ui").nav_file(3)<cr>',        desc = "Harpoon 3" },
    { "<A-l>",      '<cmd>lua require("harpoon.ui").nav_file(4)<cr>',        desc = "Harpoon 4" },
    { "<leader>hp", '<cmd>lua require("harpoon.ui").nav_prev()<cr>',         desc = "Harpoon Prev" },
    { "<leader>hn", '<cmd>lua require("harpoon.ui").nav_next()<cr>',         desc = "Harpoon Next" },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "nvim-telescope/telescope.nvim",
      lazy = true,
      config = function()
        require("telescope").load_extension("harpoon")
      end,
    },
  },
}
