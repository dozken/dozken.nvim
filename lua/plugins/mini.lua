return {
  {
    'echasnovski/mini.files',
    enabled = false,
    version = '*',
    opts = {}
  },
  {
    'echasnovski/mini.comment',
    version = '*',
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    opts = {}
  },
  {
    'echasnovski/mini.pairs',
    version = '*',
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    opts = {}
  },
  {
    "echasnovski/mini.indentscope",
    version = '*',
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    opts = {
      -- symbol = "▏",
      symbol = "│",
      options = { try_as_border = true },
    },
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "help",
          "alpha",
          "dashboard",
          "neo-tree",
          "Trouble",
          "lazy",
          "mason",
          "notify",
          "toggleterm",
          "lazyterm",
        },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
    end,
  }
}
