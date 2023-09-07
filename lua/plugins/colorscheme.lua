return {
  {
    'folke/tokyonight.nvim',
    lazy = true,
    -- priority = 1000,
    opts = { style = 'moon' },
    config = function()
      vim.cmd.colorscheme 'tokyonight-moon'
    end,
  },

  {
    'rose-pine/neovim',
    name = 'rose-pine',
    event = { 'VimEnter' },
    priority = 1000,
    opts = {
      --- @usage 'auto'|'main'|'moon'|'dawn'
      variant = 'main',
    },
    config = function()
      vim.cmd.colorscheme 'rose-pine'
    end,
  },
}
