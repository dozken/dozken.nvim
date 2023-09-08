return {
  -- Git related plugins
  {
    "ThePrimeagen/git-worktree.nvim",
    keys = {
      {
        "<leader>gw",
        '<CMD>lua require("telescope").extensions.git_worktree.git_worktrees()<CR>',
        desc = "[G]it [W]orktree"
      },
    },
    dependencies = {
      "nvim-telescope/telescope.nvim",
      config = function()
        require("telescope").load_extension("git_worktree")
      end,
    },
  },
  {
    'kdheepak/lazygit.nvim',
    keys = {
      { '<leader>gg', '<cmd>LazyGit<cr>', desc = 'LazyGit' },
    },
    cmd = 'LazyGit',
    --   -- optional for floating window border decoration
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
  },
  {
    'tpope/vim-fugitive',
    cmd = 'Git'
  },
  -- 'tpope/vim-rhubarb',
  -- Detect tabstop and shiftwidth automatically
  -- 'tpope/vim-sleuth',
  {
    -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    opts = {
      -- See `:help gitsigns.txt`
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      on_attach = function(bufnr)
        vim.keymap.set('n', '<leader>hp', require('gitsigns').preview_hunk, { buffer = bufnr, desc = 'Preview git hunk' })

        -- don't override the built-in and fugitive keymaps
        local gs = package.loaded.gitsigns
        vim.keymap.set({ 'n', 'v' }, ']c', function()
          if vim.wo.diff then return ']c' end
          vim.schedule(function() gs.next_hunk() end)
          return '<Ignore>'
        end, { expr = true, buffer = bufnr, desc = "Jump to next hunk" })
        vim.keymap.set({ 'n', 'v' }, '[c', function()
          if vim.wo.diff then return '[c' end
          vim.schedule(function() gs.prev_hunk() end)
          return '<Ignore>'
        end, { expr = true, buffer = bufnr, desc = "Jump to previous hunk" })
      end,
    },
  },
  {
    'mbbill/undotree',
    keys = {
      { '<leader>u', '<cmd>UndotreeToggle<cr>', mode = 'n', desc = '[U]ndotree' } }
  },

}
