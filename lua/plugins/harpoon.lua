return {
  "ThePrimeagen/harpoon",
  events = "VeryLazy",
  keys = {
    { "<leader>hm", '<cmd>Telescope harpoon marks<cr>',                      desc = "[H]arpoon [M]arks" },
    { "<C-e>",      '<cmd>lua require("harpoon.ui").toggle_quick_menu()<cr>' },
    { "<leader>ha", '<cmd>lua require("harpoon.mark").add_file()<cr>',       desc = "[H]arpoon [A]dd file" },
    { "<A-h>",      '<cmd>lua require("harpoon.ui").nav_file(1)<cr>',        desc = "[H]arpoon [1]" },
    { "<A-j>",      '<cmd>lua require("harpoon.ui").nav_file(2)<cr>',        desc = "[H]arpoon [2]" },
    { "<A-k>",      '<cmd>lua require("harpoon.ui").nav_file(3)<cr>',        desc = "[H]arpoon [3]" },
    { "<A-l>",      '<cmd>lua require("harpoon.ui").nav_file(4)<cr>',        desc = "[H]arpoon [4]" },
    { "<leader>hp", '<cmd>lua require("harpoon.ui").nav_prev()<cr>',         desc = "[H]arpoon [P]rev" },
    { "<leader>hn", '<cmd>lua require("harpoon.ui").nav_next()<cr>',         desc = "[H]arpoon [N]ext" },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
  },
  config = function()
    require("telescope").load_extension("harpoon")
  end,
}
