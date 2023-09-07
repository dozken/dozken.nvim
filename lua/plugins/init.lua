return {
  -- { "nvim-tree/nvim-web-devicons", lazy = true },
  -- fun
  {
    'eandrju/cellular-automaton.nvim',
    keys = {
      { '<leader>mr',  '<cmd>CellularAutomaton make_it_rain<cr>', desc = 'Make It Rain' },
      { '<leader>gol', '<cmd>CellularAutomaton game_of_life<cr>', desc = 'Make It Rain' }
    }
  },
  -- "nvim-lua/plenary.nvim", -- lua functions that many plugins use

  -- tmux & split window navigation
  {
    "christoomey/vim-tmux-navigator",
    keys = {
      '<C-h>', '<C-j>', '<C-k>', '<C-l>'
    },
    -- event = 'VeryLazy'
  },
}
