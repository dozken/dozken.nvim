return {
        'ThePrimeagen/harpoon',
        keys = function()
                local map = function(key, func, desc)
                        return {
                                key,
                                func,
                                desc = 'Harpoon ' .. desc

                        }
                end
                return {
                        map('<leader>hu', require('harpoon.ui').toggle_quick_menu, 'UI'),
                        map('<leader>hm', require('harpoon.mark').add_file, 'Mark for Harpoon'),
                        map('<C-j>', function() require('harpoon.ui').nav_file(1) end, '1'),
                        map('<C-k>', function() require('harpoon.ui').nav_file(2) end, '2'),
                        map('<C-l>', function() require('harpoon.ui').nav_file(3) end, '3'),
                        map('<C-;>', function() require('harpoon.ui').nav_file(4) end, '4'),
                        map('<leader>hp', require('harpoon.ui').nav_prev, 'prev'),
                        map('<leader>hn', require('harpoon.ui').nav_next, 'next'),
                }
        end,
        dependencies = {
                "nvim-lua/plenary.nvim",
        },
}
