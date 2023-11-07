return {
  -- TabNine
  {
    'tzachar/cmp-tabnine',
    event = { "InsertEnter" },
    build = './install.sh',
    dependencies = { 'hrsh7th/nvim-cmp',
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
    event = { "InsertEnter" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
    },
    config = function()
      require("codeium").setup({
      })
    end
  },
}
