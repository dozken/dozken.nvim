return {
  -- TabNine
  {
    'tzachar/cmp-tabnine',
    enabled = false,
    lazy = true,
    -- event = { "VeryLazy" },
    build = './install.sh',
    dependencies = {
      'hrsh7th/nvim-cmp',
      'onsails/lspkind.nvim'
    },
    --write me a function
    config = function()
      local tabnine = require('cmp_tabnine.config')

      tabnine:setup({
        max_lines = 1000,
        max_num_results = 3,
        sort = true,
        run_on_every_keystroke = true,
        snippet_placeholder = '..',
        ignored_file_types = {
          -- default is not to ignore
          -- uncomment to ignore in lua:
          -- lua = true
        },
        show_prediction_strength = true
      })
    end
  },

  -- Codeium
  {
    "Exafunction/codeium.nvim",
    lazy = true,
    event = { "BufRead", "BufNewFile" },
    dependencies = {
      'hrsh7th/nvim-cmp',
      'onsails/lspkind.nvim',
    },
    config = function()
      require("codeium").setup({})
    end
  },
}
