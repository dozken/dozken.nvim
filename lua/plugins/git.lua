return {
  -- Git related plugins
  {
    "ThePrimeagen/git-worktree.nvim",
    -- event = { "VimEnter" },
    keys = {
      {
        "<leader>gw",
        '<CMD>lua require("telescope").extensions.git_worktree.git_worktrees()<CR>',
        desc = "[G]it [W]orktree"
      },
      {
        "<leader>gW",
        "<CMD>lua require('telescope').extensions.git_worktree.create_git_worktree()<CR>",
        desc = "Git Worktree Create",
      },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope.nvim",
        config = function()
          require("telescope").load_extension("git_worktree")
        end,
      },
    },
    config = function()
      local Job = require("plenary.job")
      local Worktree = require("git-worktree")

      local function setup_msdirect_repos(prev_path, worktree_path)
        local copy_env = Job:new({
          command = "ln",
          args = { "-s", prev_path .. "/.env", "./" .. worktree_path },
          cwd = prev_path,
          on_success = function()
            print("Linked .env from " .. prev_path .. " to " .. worktree_path)
          end,
        })

        local copy_npmrc = Job:new({
          command = "ln",
          args = { "-s", prev_path .. "/.npmrc", "./" .. worktree_path },
          cwd = prev_path,
          on_success = function()
            print("Linked .npmrc from " .. prev_path .. " to " .. worktree_path)
          end,
        })

        local install_dependencies_job = Job:new({
          command = "pnpm",
          args = { "install" },
          cwd = prev_path .. '/' .. worktree_path,
          on_exit = function()
            print("Installed dependencies")
          end,
        })

        copy_env:start()
        copy_npmrc:start()
        install_dependencies_job:start()
      end

      Worktree.on_tree_change(function(op, metadata)
        if op == Worktree.Operations.Create then
          print("Created " .. metadata.path .. ' and ' .. vim.fn.getcwd())

          if string.find(vim.fn.getcwd(), "msdirect") then
            setup_msdirect_repos(vim.fn.getcwd(), metadata.path)
          end
        end

        if op == Worktree.Operations.Switch then
          print("Switch from " .. metadata.prev_path .. " to " .. metadata.path)
        end
      end)
    end
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
