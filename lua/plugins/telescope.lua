return {
  'nvim-telescope/telescope.nvim',
  cmd = 'Telescope',
  branch = '0.1.x',
  opts = {
    defaults = {
      mappings = {
        i = {
          ['<C-u>'] = false,
          ['<C-d>'] = false,
        },
      },
    },
  },
  keys = {
    -- {'<leader>fp',        function() require('telescope.builtin').find_files({ cwd = require('lazy.core.config').options.root }) end,    desc = 'Find Plugin File',},
    -- See `:help telescope.builtin`
    { '<leader>?',       '<cmd>Telescope oldfiles<cr>',                  desc = '[?] Find recently opened files' },
    { '<leader><space>', '<cmd>Telescope buffers<cr>',                   desc = '[ ] Find existing buffers' },
    { '<leader>/',       '<cmd>Telescope current_buffer_fuzzy_find<cr>', desc = '[/] Fuzzily search in current buffer' },
    { '<leader>gf',      '<cmd>Telescope git_files<cr>',                 desc = 'Search Git Files' },
    { '<leader>sf',      '<cmd>Telescope find_files<cr>',                desc = 'Search Files' },
    { '<leader>sh',      '<cmd>Telescope help_tags<cr>',                 desc = 'Search Help' },
    { '<leader>sw',      '<cmd>Telescope grep_string<cr>',               desc = 'Search current Word' },
    { '<leader>sg',      '<cmd>Telescope live_grep<cr>',                 desc = 'Search by Grep' },
    { '<leader>sd',      '<cmd>Telescope diagnostics<cr>',               desc = 'Search Diagnostics' },
    { '<leader>sr',      '<cmd>Telescope resume<cr>',                    desc = 'Search Resume' },
  },
  dependencies = {
    'nvim-lua/plenary.nvim',
    -- Fuzzy Finder Algorithm which requires local dependencies to be built.
    -- Only load if `make` is available. Make sure you have the system
    -- requirements installed.
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      -- NOTE: If you are having trouble with this installation,
      --       refer to the README for telescope-fzf-native for more instructions.
      build = 'make',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
      lazy = true,
      config = function()
        require('telescope').load_extension('fzf')
      end,
    },
  },
  config = function()
  end
}
