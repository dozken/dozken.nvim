return {
  -- {
  --     'echasnovski/mini.files',
  --     enabled = false,
  --     version = '*',
  --     config = true,
  -- },
  -- {
  --     'echasnovski/mini.comment',
  --     enabled=false,
  --     version = '*',
  --     event = { "BufReadPost", "BufNewFile", "BufWritePre" },
  --     config = true,
  -- },
  -- {
  --     'echasnovski/mini.pairs',
  --     version = '*',
  --     event = { "BufReadPost", "BufNewFile", "BufWritePre" },
  --     config = true,
  -- },
  {
    'echasnovski/mini.indentscope',
    version = '*',
    event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' },
    opts = {
      -- symbol = "▏",
      symbol = '│',
      options = { try_as_border = true },
    },
    -- init = function()
    --     vim.api.nvim_create_autocmd("FileType", {
    --         pattern = {
    --             "help",
    --             "alpha",
    --             "dashboard",
    --             "neo-tree",
    --             "Trouble",
    --             "lazy",
    --             "mason",
    --             "notify",
    --             "toggleterm",
    --             "lazyterm",
    --         },
    --         callback = function()
    --             vim.b.miniindentscope_disable = true
    --         end,
    --     })
    -- end,
    config = true,
  },

  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },
  {
    'echasnovski/mini.ai',
    event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' },
    opts = {
      n_lines = 500,
    },
    config = true,
  },
  { 'echasnovski/mini.surround', version = '*', event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' }, config = true },
  {
    'echasnovski/mini.hipatterns',
    enabled = false,
    version = '*',
    event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' },
    -- opts = {
    --   highlighters = {
    --     -- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
    --     fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
    --     hack = { pattern = '%f[%w]()HACK()%f[%W]', group = 'MiniHipatternsHack' },
    --     todo = { pattern = '%f[%w]()TODO()%f[%W]', group = 'MiniHipatternsTodo' },
    --     note = { pattern = '%f[%w]()NOTE()%f[%W]', group = 'MiniHipatternsNote' },
    --     text = { pattern = '%f[%w]()TEXT()%f[%W]', group = 'MiniHipatternsText' },
    --
    --     -- Highlight hex color strings (`#rrggbb`) using that color
    --     -- hex_color = hipatterns.gen_highlighter.hex_color(),
    --   },
    -- },
  },
}
