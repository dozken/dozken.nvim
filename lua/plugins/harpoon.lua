return {
  'ThePrimeagen/harpoon',
  events = 'VeryLazy',
  keys = {
    { '<leader>hm', '<cmd>Telescope harpoon marks<cr>',                desc = '[H]arpoon [M]arks' },
    { '<leader>ha', '<cmd>lua require("harpoon.mark").add_file()<cr>', desc = '[H]arpoon [A]dd file' },
    { '<leader>h1', '<cmd>lua require("harpoon.ui").nav_file(1)<cr>',  desc = '[H]arpoon [1]' },
    { '<leader>h2', '<cmd>lua require("harpoon.ui").nav_file(2)<cr>',  desc = '[H]arpoon [2]' },
    { '<leader>h3', '<cmd>lua require("harpoon.ui").nav_file(3)<cr>',  desc = '[H]arpoon [3]' },
    { '<leader>h4', '<cmd>lua require("harpoon.ui").nav_file(4)<cr>',  desc = '[H]arpoon [4]' },
    { '<leader>hp', '<cmd>lua require("harpoon.ui").nav_prev()<cr>',   desc = '[H]arpoon [P]rev' },
    { '<leader>hn', '<cmd>lua require("harpoon.ui").nav_next()<cr>',   desc = '[H]arpoon [N]ext' }
  },
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope.nvim',
      config = function()
        require('telescope').load_extension('harpoon')
      end
    }
  },
}
