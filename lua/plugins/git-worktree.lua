return {
	"ThePrimeagen/git-worktree.nvim",
	keys = {
		{
			"<leader>gw",
			function()
				require("telescope").extensions.git_worktree.git_worktrees()
			end,
			desc = "Git Worktree",
		},
	},
	config = function()
		require("telescope").load_extension("git_worktree")
	end,
	dependencies = {
		"nvim-telescope/telescope.nvim",
	},
}
