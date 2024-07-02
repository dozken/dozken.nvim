return {
  -- Codeium
  {
    'Exafunction/codeium.nvim',
    lazy = true,
    -- event = { 'BufRead', 'BufNewFile' },
    dependencies = {
      'hrsh7th/nvim-cmp',
      'onsails/lspkind.nvim',
    },
    config = true,
  },

  -- GPT
  {
    'jackMort/ChatGPT.nvim',
    enabled = false,
    event = 'VeryLazy',
    dependencies = {
      'MunifTanjim/nui.nvim',
      'nvim-lua/plenary.nvim',
      'folke/trouble.nvim',
      'nvim-telescope/telescope.nvim',
    },
    config = function()
      require('chatgpt').setup {
        api_key_cmd = 'echo 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',
      }
    end,
  },
  -- TabNine
  {
    'tzachar/cmp-tabnine',
    enabled = false,
    -- event = { "VeryLazy" },
    build = './install.sh',
    dependencies = {
      'hrsh7th/nvim-cmp',
      'onsails/lspkind.nvim',
    },
    --write me a function
    config = function()
      local tabnine = require 'cmp_tabnine.config'

      tabnine:setup {
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
        show_prediction_strength = true,
      }
    end,
  },
}
