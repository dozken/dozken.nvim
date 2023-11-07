return {
  {
    'echasnovski/mini.statusline',
    enabled = false,
    event = "VimEnter",
    version = '*',
    opt = {},
    config = function()
      require('mini.statusline').setup()
    end
  },
  {
    'nvim-lualine/lualine.nvim',
    -- enabled = false,
    -- event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    event = "VimEnter",
    init = function()
      vim.opt.shortmess:append({ W = true, I = false, c = true })
    end,
    opts = {
      sections = {
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = {
          { "filename", path = 1, symbols = { modified = "  ", readonly = "", unnamed = "" } },
        },
        lualine_y = {
          { "progress", padding = { left = 1, right = 0 }, separator = " " },
          { "location", padding = { left = 0, right = 1 } },
        },
        lualine_z = {
          function()
            return " " .. os.date("%R")
          end,
        },
      },
      options = {
        section_separators = ""
        -- { left = '', right = '' },
      }
    },
  }
}
