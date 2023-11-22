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
  -- event = "UIEnter",
  -- lazy = true,
  keys = {
    -- {'<leader>fp',        function() require('telescope.builtin').find_files({ cwd = require('lazy.core.config').options.root }) end,    desc = 'Find Plugin File',},
    -- See `:help telescope.builtin`
    { '<leader>?',       '<cmd>Telescope oldfiles<cr>',                  desc = '[?] Find recently opened files' },
    { '<leader><space>', '<cmd>Telescope buffers<cr>',                   desc = '[ ] Find existing buffers' },
    { '<leader>/',       '<cmd>Telescope current_buffer_fuzzy_find<cr>', desc = '[/] Fuzzily search in current buffer' },
    { '<leader>gf',      '<cmd>Telescope git_files<cr>',                 desc = 'Search [G]it [F]iles' },
    { '<leader>sf',      '<cmd>Telescope find_files<cr>',                desc = '[S]earch [F]iles' },
    { '<leader>sh',      '<cmd>Telescope help_tags<cr>',                 desc = '[S]earch [H]elp' },
    { '<leader>sw',      '<cmd>Telescope grep_string<cr>',               desc = '[S]earch current [W]ord' },
    { '<leader>sg',      '<cmd>Telescope live_grep<cr>',                 desc = '[S]earch by [G]rep' },
    { '<leader>sd',      '<cmd>Telescope diagnostics<cr>',               desc = '[S]earch [D]iagnostics' },
    { '<leader>sr',      '<cmd>Telescope resume<cr>',                    desc = '[S]earch [R]esume' },
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
