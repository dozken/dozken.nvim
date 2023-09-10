return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = true,
    -- event = { "VimEnter" },
    -- priority = 10000,
    config = function()
      vim.cmd.colorscheme 'catppuccin-mocha'
    end,
  },
  {
    'folke/tokyonight.nvim',
    lazy = true,
    -- event = { "VimEnter" },
    -- priority = 10000,
    opts = { style = 'moon' },
    config = function()
      vim.cmd.colorscheme 'tokyonight-moon'
    end,
  },

  {
    'rose-pine/neovim',
    name = 'rose-pine',
    lazy = true,
    event = { "VimEnter" },
    priority = 10000,
    config = function()
      vim.cmd.colorscheme 'rose-pine-moon'
    end,
  },
}
