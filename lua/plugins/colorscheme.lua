return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = true,
    event = { "VimEnter" },
    priority = 1000,
    opts = {
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
          indentscope_color = "",
        },

      }
    },
    config = function(_, opts)
      require('catppuccin').setup(opts)
      vim.cmd.colorscheme 'catppuccin-mocha'
    end,
  },
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

  -- {
  --   'rose-pine/neovim',
  --   event = { "VimEnter" },
  --   enabled = true,
  --   name = 'rose-pine',
  --   lazy = true,
  --   priority = 1000,
  --   config = function()
  --
  --     require('rose-pine').setup({
  --       disable_background = true,
  --       highlight_groups = {
  --         TelescopeBorder = { fg = "highlight_high", bg = "none" },
  --         TelescopeNormal = { bg = "none" },
  --         TelescopePromptNormal = { bg = "none" },
  --         TelescopeResultsNormal = { fg = "subtle", bg = "none" },
  --         TelescopeSelection = { fg = "text", bg = "base" },
  --         TelescopeSelectionCaret = { fg = "rose", bg = "rose" },
  --       },
  --     })
  --     --
  --     -- Set colorscheme after options
  --     vim.cmd('colorscheme rose-pine')
  --   end,
  -- },
}
