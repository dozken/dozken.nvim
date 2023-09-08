return {
  -- { "nvim-tree/nvim-web-devicons", lazy = true },

  -- tmux & split window navigation
  {
    "christoomey/vim-tmux-navigator",
    keys = {
      '<C-h>', '<C-j>', '<C-k>', '<C-l>'
    },
  },

  -- fun
  {
    'eandrju/cellular-automaton.nvim',
    keys = {
      { '<leader>mr',  '<cmd>CellularAutomaton make_it_rain<cr>', desc = 'Make It Rain' },
      { '<leader>gol', '<cmd>CellularAutomaton game_of_life<cr>', desc = 'Game Of Life' }
    }
  },

}
