return {
  'ThePrimeagen/harpoon',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
  },
  events = 'VeryLazy',
  keys = function()
    local map = function(key, func, desc)
      return {
        key,
        func,
        desc = '[H]arpoon ' .. desc

      }
    end
    return {
      map('<leader>hm', '<cmd>Telescope harpoon marks<cr>', '[M]arks'),
      map('<leader>ha', function() require('harpoon.mark').add_file() end, '[A]dd file'),
      map('<leader>h1', function() require('harpoon.ui').nav_file(1) end, '[1]'),
      map('<leader>h2', function() require('harpoon.ui').nav_file(2) end, '[2]'),
      map('<leader>h3', function() require('harpoon.ui').nav_file(3) end, '[3]'),
      map('<leader>h4', function() require('harpoon.ui').nav_file(4) end, '[4]'),
      map('<leader>hp', function() require('harpoon.ui').nav_prev() end, '[P]rev'),
      map('<leader>hn', function() require('harpoon.ui').nav_next() end, '[N]ext'),
    }
  end,
  config = function()
    require('telescope').load_extension('harpoon')
  end
}
