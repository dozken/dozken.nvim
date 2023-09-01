return {
	'ThePrimeagen/harpoon',
	keys = {
		{
			'<C-e>',
			function()
				require('harpoon.ui').toggle_quick_menu()
			end,
			desc = 'Open Harpoon',
		},
		{
			'<leader>a',
			function()
				require('harpoon.mark').add_file()
			end,
			desc = 'Mark for Harpoon'
		},

		-- Harpoon marked files 1 through 4.
		{
			'<C-j>',
			function()
				require('harpoon.ui').nav_file(1)
			end,
			desc = 'Harpoon 1'
		},
		{
			'<C-k>',
			function()
				require('harpoon.ui').nav_file(2)
			end,
			desc = 'Harpoon 2'
		},
		{
			'<C-l>',
			function()
				require('harpoon.ui').nav_file(3)
			end,
			desc = 'Harpoon 3'
		},
		{
			'<C-;>',
			function()
				require('harpoon.ui').nav_file(4)
			end,
			desc = 'Harpoon 4'
		},
		-- Harpoon next & prev
		{
			'<A-n>',
			function()
				require('harpoon.ui').nav_next()
			end,
			desc = 'Harpoon next'
		},
		{
			'<A-p>',
			function()
				require('harpoon.ui').nav_next()
			end,
			desc = 'Harpoon next'
		},
	},
}
