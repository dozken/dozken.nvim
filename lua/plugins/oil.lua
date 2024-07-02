return {
  'stevearc/oil.nvim',
  cmd = 'Oil',
  keys = { { '<leader>n', '<cmd>Oil<cr>', desc = 'Open Oil' } },
  config = function()
    require('oil').setup {
      view_options = {
        -- Show files and directories that start with "."
        show_hidden = true,
      },
    }
  end,

  -- Optional dependencies
  dependencies = { 'nvim-tree/nvim-web-devicons' },
}
