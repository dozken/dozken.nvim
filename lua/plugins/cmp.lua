return {
    {
        "hrsh7th/nvim-cmp",
        event = { "BufRead", "BufNewFile" },
        dependencies = {
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-nvim-lsp",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
            "rafamadriz/friendly-snippets",
            "onsails/lspkind.nvim",
            {
                "dozken/LuaSnip-snippets.nvim",
                branch = "feature/ts_builder_snips",
            }
        },
        opts = function()
            vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
            local cmp = require "cmp"
            local luasnip = require "luasnip"
            luasnip.config.setup {}
            require("luasnip.loaders.from_vscode").lazy_load()
            luasnip.snippets = require("luasnip_snippets").load_snippets()

            local lspkind = require "lspkind"
            return {
                window = {},
                preselect = 'item',
                completion = {
                    completeopt = "menu,menuone,preview,noselect",
                },
                snippet = {
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
                    ['<C-y>'] = cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Replace, select = true },
                    ['<CR>'] = cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Replace, select = true },
                    ['<C-l>'] = cmp.mapping(function(fallback)
                        if luasnip.expand_or_locally_jumpable() then
                            luasnip.expand_or_jump()
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                    ['<C-h>'] = cmp.mapping(function(fallback)
                        if luasnip.locally_jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                },
                sources = cmp.config.sources {
                    { name = "codeium" },
                    { name = "cmp_tabnine" },
                    { name = "luasnip" },
                    { name = "nvim_lsp" },
                    { name = "nvim_lua" },
                    { name = "buffer" },
                    { name = "path" },
                },
                formatting = {
                    fields = { 'abbr', 'kind', 'menu' },
                    format = lspkind.cmp_format({
                        mode = "text_symbol",
                        maxwidth = 50,
                        ellipsis_char = "...",
                        symbol_map = { Codeium = "", TabNine = "" },
                        menu = {
                            luasnip = "[Snips]",
                            nvim_lsp = "[LSP]",
                            nvim_lua = "[Lua]",
                            codeium = "[Codeium]",
                            cmp_tabnine = "[TabNine]",
                            buffer = "[Buffer]",
                            path = "[Path]",
                        },
                    })
                },
                experimental = {
                    ghost_text = { hl_group = "CmpGhostText" },
                },
            }
        end,
    }
}
