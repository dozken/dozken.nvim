-- if true then return {} end
return {
    "hrsh7th/nvim-cmp",
    event = { "BufRead", "BufNewFile" },
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
        }
    },
    config = function()
        vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
        local cmp = require "cmp"

        local luasnip = require "luasnip"
        require("luasnip.loaders.from_vscode").lazy_load()
        luasnip.config.setup {}
        luasnip.snippets = require("luasnip_snippets").load_snippets()


        local defaults = require("cmp.config.default")()

        local lspkind = require "lspkind"

        ---@diagnostic disable-next-line: missing-fields
        cmp.setup {
            preselect = 'item',
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
                ['<C-y>'] = cmp.mapping.confirm {
                    behavior = cmp.ConfirmBehavior.Replace,
                    select = true,
                },
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
                { name = "codeium" },
                { name = "cmp_tabnine" },
                { name = "luasnip" },
                { name = "nvim_lsp" },
                { name = "nvim_lua" },
                { name = "buffer" },
                { name = "path" },
            },
            -- configure lspkind for vs-code like pictograms in completion menu
            ---@diagnostic disable-next-line: missing-fields
            formatting = {
                fields = { 'abbr', 'kind', 'menu' },
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
                })
            },
            experimental = {
                ghost_text = {
                    hl_group = "CmpGhostText",
                },
            },
        }
    end,
}
