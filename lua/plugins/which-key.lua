return {
  'folke/which-key.nvim',
  event = 'UIEnter',
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  },
  config = function()
    require('which-key').register {
      ['<leader>g'] = { name = '[G]it', _ = 'which_key_ignore' },
      ['<leader>h'] = { name = '[H]arpoon', _ = 'which_key_ignore' },
      ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
      ['<leader>f'] = { name = '[F]ormat', _ = 'which_key_ignore' },
      ['<leader>e'] = { name = 'Neotree [E]xplorer', _ = 'which_key_ignore' },
      ['<leader>z'] = { name = '[Z]en mode', _ = 'which_key_ignore' },
    }
  end,
}
