return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-buffer",           -- source for text in buffer
    "hrsh7th/cmp-path",             -- source for file system paths
    "L3MON4D3/LuaSnip",             -- snippet engine
    "saadparwaiz1/cmp_luasnip",     -- for autocompletion
    "rafamadriz/friendly-snippets", -- useful snippets
    "onsails/lspkind.nvim",         -- vs-code like pictograms
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
    vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
    local cmp = require "cmp"

    local luasnip = require "luasnip"
    local defaults = require("cmp.config.default")()

    local lspkind = require "lspkind"

    -- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
    require("luasnip.loaders.from_vscode").lazy_load()

    local compare = require("cmp.config.compare")
    ---@diagnostic disable-next-line: missing-fields
    cmp.setup {
      ---@diagnostic disable-next-line: missing-fields
      completion = {
        -- completeopt = "menu,menuone,preview,noselect",
        completeopt = "menu,menuone,noinsert",
      },
      snippet = { -- configure how nvim-cmp interacts with snippet engine
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert {
        ["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
        ["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
        ["<C-e>"] = cmp.mapping.abort(),        -- close completion window
        ["<CR>"] = cmp.mapping.confirm { select = false },
      },
      -- sources for autocompletion
      sources = cmp.config.sources {
        { name = "nvim_lsp" },
        { name = "codeium" },
        { name = "cmp_tabnine" },
        { name = "luasnip" },
        { name = "nvim_lua" },
        { name = "buffer" },
        { name = "path" },
      },
      -- configure lspkind for vs-code like pictograms in completion menu
      ---@diagnostic disable-next-line: missing-fields
      formatting = {
        format = lspkind.cmp_format({
          mode = "text_symbol",  -- show only symbol annotations
          maxwidth = 50,         -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
          ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
          symbol_map = {
            Codeium = "",
            TabNine = ""
          },
          menu = {
            nvim_lsp = "[LSP]",
            codeium = "[Codeium]",
            cmp_tabnine = "[TabNine]",
            luasnip = "[LuaSnip]",
            nvim_lua = "[Lua]",
            buffer = "[Buffer]",
            path = "[Path]",
          },

          -- The function below will be called before any actual modifications from lspkind
          -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
          before = function(entry, vim_item)
            -- show prediction strength
            if entry.source.name == "cmp_tabnine" then
              local detail = (entry.completion_item.labelDetails or {}).detail
              if detail and detail:find(".*%%.*") then
                vim_item.kind = vim_item.kind .. " " .. detail
              end
              if (entry.completion_item.data or {}).multiline then
                vim_item.kind = vim_item.kind .. " " .. "[ML]"
              end
            end
            return vim_item
          end
        })
      },
      experimental = {
        ghost_text = {
          hl_group = "CmpGhostText",
        },
      },
      sorting = defaults.sorting,
      -- sorting = {
      --   priority_weight = 2,
      --   comparators = {
      --     require("cmp_tabnine.compare"),
      --     -- require("codeium.compare"),
      --     compare.offset,
      --     compare.exact,
      --     compare.score,
      --     compare.recently_used,
      --     compare.kind,
      --     compare.sort_text,
      --     compare.length,
      --     compare.order,
      --   },
      -- },
    }
  end,
}
