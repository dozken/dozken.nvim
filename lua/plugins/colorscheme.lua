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
  --   lazy = false,
  --   event = { "VimEnter" },
  --   priority = 1000,
  --   opts = { style = 'moon' },
  --   config = function()
  --     vim.cmd.colorscheme 'tokyonight-moon'
  --   end,
  -- },

  {
    'rose-pine/neovim',
    -- event = { "VimEnter" },
    enabled = true,
    name = 'rose-pine',
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'rose-pine-main'
    end,
  },
}
