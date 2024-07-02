return {

  {
    'catppuccin/nvim',
    event = 'VimEnter',
    name = 'catppuccin',
    priority = 1000,
    opts = {
      styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
        comments = { 'italic' }, -- Change the style of comments
      },
      transparent_background = true,

      intergrations = {
        treesitter = true,
        treesitter_context = false,
        mason = true,
        cmp = true,
        harpoon = true,
        fidget = true,
        telescope = true,
        mini = {
          enabled = true,
          indentscope_color = '',
        },
      },
    },
    config = function(_, opts)
      require('catppuccin').setup(opts)
      vim.cmd.colorscheme 'catppuccin-mocha'
    end,
  },

  {
    'ellisonleao/gruvbox.nvim',
    enabled = false,
    lazy = true,
    opts = {
      transparent_mode = true,
    },
    config = true,
  },

  {
    'folke/tokyonight.nvim',
    lazy = true,
    opts = { style = 'night', transparent = true },
    config = function(_, opts)
      require('tokyonight').setup(opts)
      vim.cmd.colorscheme 'tokyonight'
    end,
  },

  {
    'rose-pine/neovim',
    enabled = false,
    lazy = true,
    name = 'rose-pine',
    opts = {
      styles = {
        transparency = true,
      },
    },
    config = function(_, opts)
      require('rose-pine').setup(opts)
      vim.cmd.colorscheme 'rose-pine'
    end,
  },
}
