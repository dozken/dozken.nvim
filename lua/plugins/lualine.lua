return {
  'nvim-lualine/lualine.nvim',
  event = "VeryLazy",
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
  },
}
