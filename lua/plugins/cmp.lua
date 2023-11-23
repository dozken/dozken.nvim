return {
  "hrsh7th/nvim-cmp",
  event = { "InsertEnter" },
  lazy = true,
  dependencies = {
    "hrsh7th/cmp-buffer", -- source for text in buffer
    "hrsh7th/cmp-path",   -- source for file system paths
    "hrsh7th/cmp-nvim-lsp",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",     -- for autocompletion
    "rafamadriz/friendly-snippets", -- useful snippets
    "onsails/lspkind.nvim",         -- vs-code like pictograms
    {
      "dozken/LuaSnip-snippets.nvim",
      branch = "feature/ts_builder_snips",
      dependencies = {
        "L3MON4D3/LuaSnip"
      },
      config = function()
        local luasnip = require "luasnip"
        luasnip.snippets = require("luasnip_snippets").load_snippets()
      end
    }
  },
  config = function()
    vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
    local cmp = require "cmp"

    local luasnip = require "luasnip"
    -- luasnip.snippets = require("luasnip_snippets").load_snippets()
    -- loads snippets from the luasnippents dir
    -- luasnip.snippets = require("luasnip-snippets").load_snippets()
    -- require("luasnip.loaders.from_lua").load({ paths = "./luasnippets" })
    -- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
    require("luasnip.loaders.from_vscode").lazy_load()
    luasnip.config.setup {}


    local defaults = require("cmp.config.default")()

    local lspkind = require "lspkind"

    ---@diagnostic disable-next-line: missing-fields
    cmp.setup {
      ---@diagnostic disable-next-line: missing-fields
      completion = {
        completeopt = "menu,menuone,preview,noselect",
        -- completeopt = "menu,menuone,noinsert",
      },
      snippet = {
        -- configure how nvim-cmp interacts with snippet engine
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert {
        ['<C-j>'] = cmp.mapping.select_next_item(),
        ['<C-k>'] = cmp.mapping.select_prev_item(),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete {},
        ['<CR>'] = cmp.mapping.confirm {
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        },
        ['<C-l>'] = cmp.mapping(function(fallback)
          -- if cmp.visible() then
          -- cmp.select_next_item()
          -- else
          if luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { 'i', 's' }),
        ['<C-h>'] = cmp.mapping(function(fallback)
          -- if cmp.visible() then
          -- cmp.select_prev_item()
          -- else
          if luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { 'i', 's' }),
      },
      -- sources for autocompletion
      sources = cmp.config.sources {
        { name = "luasnip" },
        { name = "nvim_lsp" },
        { name = "nvim_lua" },
        { name = "codeium" },
        { name = "cmp_tabnine" },
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
            luasnip = "[Snips]",
            nvim_lsp = "[LSP]",
            nvim_lua = "[Lua]",
            codeium = "[Codeium]",
            cmp_tabnine = "[TabNine]",
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
      ---@diagnostic disable-next-line: missing-fields
      sorting = defaults.sorting,
      -- sorting = {
      --   -- TODO: Would be cool to add stuff like "See variable names before method names" in rust, or something like that.
      --   comparators = {
      --     cmp.config.compare.offset,
      --     cmp.config.compare.exact,
      --     cmp.config.compare.score,
      --
      --     -- copied from cmp-under, but I don't think I need the plugin for this.
      --     -- I might add some more of my own.
      --     function(entry1, entry2)
      --       local _, entry1_under = entry1.completion_item.label:find "^_+"
      --       local _, entry2_under = entry2.completion_item.label:find "^_+"
      --       entry1_under = entry1_under or 0
      --       entry2_under = entry2_under or 0
      --       if entry1_under > entry2_under then
      --         return false
      --       elseif entry1_under < entry2_under then
      --         return true
      --       end
      --     end,
      --
      --     cmp.config.compare.kind,
      --     cmp.config.compare.sort_text,
      --     cmp.config.compare.length,
      --     cmp.config.compare.order,
      --   },
      -- },
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
