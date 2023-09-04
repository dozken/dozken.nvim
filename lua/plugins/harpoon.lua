return {
        'ThePrimeagen/harpoon',
        dependencies = {
                "nvim-lua/plenary.nvim",
        },
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
                        map('<leader>ha', require('harpoon.mark').add_file, '[A]dd file'),
                        map('<C-j>', function() require('harpoon.ui').nav_file(1) end, '[1]'),
                        map('<C-k>', function() require('harpoon.ui').nav_file(2) end, '[2]'),
                        map('<C-l>', function() require('harpoon.ui').nav_file(3) end, '[3]'),
                        map('<C-;>', function() require('harpoon.ui').nav_file(4) end, '[4]'),
                        map('<leader>hp', require('harpoon.ui').nav_prev, '[P]rev'),
                        map('<leader>hn', require('harpoon.ui').nav_next, '[N]ext'),
                }
        end,
        config = function()
                require('telescope').load_extension('harpoon')
        end
}
