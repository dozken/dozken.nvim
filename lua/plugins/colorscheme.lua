return {
  -- {
  --   "catppuccin/nvim",
  --   name = "catppuccin",
  --   enabled = false,
  --   lazy = false,
  --   event = { "VimEnter" },
  --   priority = 1000,
  --   config = function()
  --     vim.cmd.colorscheme 'catppuccin-mocha'
  --   end,
  -- },
  --
  -- {
  --   'folke/tokyonight.nvim',
  --   enabled = false,
  --   lazy = true,
  --   event = { "VimEnter" },
  --   priority = 1000,
  --   opts = { style = 'moon' },
  --   config = function()
  --     vim.cmd.colorscheme 'tokyonight-moon'
  --   end,
  -- },

  {
    'rose-pine/neovim',
    event = { "UIEnter" },
    enabled = true,
    name = 'rose-pine',
    lazy = true,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'rose-pine-main'
    end,
  },
}
