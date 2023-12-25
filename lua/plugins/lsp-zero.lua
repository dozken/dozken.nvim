if true then return {} end

return {
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        lazy = true,
        config = false,
        init = function()
            -- Disable automatic setup, we are doing it manually
            vim.g.lsp_zero_extend_cmp = 0
            vim.g.lsp_zero_extend_lspconfig = 0
        end,
        dependencies = {
            {
                "j-hui/fidget.nvim",
                opts = {
                    notification = {
                        window = {
                            winblend = 0
                        }
                    }
                },
            }
        }
    },
    {
        'williamboman/mason.nvim',
        lazy = false,
        config = true,
    },

    -- Autocompletion
    {
        'hrsh7th/nvim-cmp',
        event = 'InsertEnter',
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
            local luasnip = require "luasnip"
            require("luasnip.loaders.from_vscode").lazy_load()
            luasnip.config.setup {}

            -- Here is where you configure the autocompletion settings.
            local lsp_zero = require('lsp-zero')
            lsp_zero.extend_cmp()

            -- And you can configure cmp even more, if you want to.
            local cmp = require('cmp')
            local cmp_action = lsp_zero.cmp_action()

            cmp.setup({
                preselect = 'item',
                completion = {
                    completeopt = 'menu,menuone,noinsert'
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-y>'] = cmp.mapping.confirm {
                        behavior = cmp.ConfirmBehavior.Replace,
                        select = true,
                    },
                    ['<CR>'] = cmp.mapping.confirm {
                        behavior = cmp.ConfirmBehavior.Replace,
                        select = true,
                    },
                    ['<C-j>'] = cmp.mapping.select_next_item(),
                    ['<C-k>'] = cmp.mapping.select_prev_item(),
                    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-d>'] = cmp.mapping.scroll_docs(4),
                    ['<C-f>'] = cmp_action.luasnip_jump_forward(),
                    ['<C-b>'] = cmp_action.luasnip_jump_backward(),
                }),

                sources = cmp.config.sources {
                    { name = "codeium" },
                    { name = "cmp_tabnine" },
                    { name = "luasnip" },
                    { name = "nvim_lsp" },
                    { name = "nvim_lua" },
                    { name = "buffer" },
                    { name = "path" },
                },
                ---@diagnostic disable-next-line: missing-fields
                formatting = {
                    fields = { 'abbr', 'kind', 'menu' },
                    format = require('lspkind').cmp_format({
                        mode = 'text_symbol',  -- show only symbol annotations
                        maxwidth = 50,         -- prevent the popup from showing more than provided characters
                        ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead
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
                    }),
                },
                experimental = {
                    ghost_text = {
                        hl_group = "CmpGhostText",
                    },
                },
            })
        end
    },

    -- LSP
    {
        'neovim/nvim-lspconfig',
        cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = {
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'williamboman/mason-lspconfig.nvim' },
        },
        config = function()
            -- This is where all the LSP shenanigans will live
            local lsp_zero = require('lsp-zero')
            lsp_zero.extend_lspconfig()

            lsp_zero.on_attach(function(client, bufnr)
                -- see :help lsp-zero-keybindings
                -- to learn the available actions
                lsp_zero.default_keymaps({ buffer = bufnr })

                local function map(m, lhs, rhs, desc)
                    vim.keymap.set(m, lhs, rhs, { buffer = bufnr, desc = desc })
                end
                local function nmap(keys, func, desc)
                    if desc then
                        desc = 'LSP: ' .. desc
                    end

                    map('n', keys, func, desc)
                end

                nmap('<leader>rn', vim.lsp.buf.rename, 'Rename')
                nmap('<leader>ca', vim.lsp.buf.code_action, 'Code Action')
                map('x', '<leader>cr', '<cmd>lua vim.lsp.buf.range_code_action()<cr>', { desc = 'Code Action Range' })

                nmap('gd', require('telescope.builtin').lsp_definitions, 'Goto Definition')
                nmap('gr', require('telescope.builtin').lsp_references, 'Goto References')
                nmap('gI', require('telescope.builtin').lsp_implementations, 'Goto Implementation')
                nmap('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type Definition')
                nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, 'Document Symbols')
                nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Workspace Symbols')

                -- nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')
                -- vim.keymap.set({ 'n', 'x' }, '<leader>f', '<cmd>lua vim.lsp.buf.format({async = true})<cr>',
                --     { buffer = bufnr })

                -- -- LSP actions
                -- map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>')
                -- map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>')
                -- map('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>')
                -- map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>')
                -- map('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>')
                -- map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>')
                -- map('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>')
                -- map('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>')
                -- map({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>')
                -- map('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>')
                -- map('x', '<F4>', '<cmd>lua vim.lsp.buf.range_code_action()<cr>')
                --
                -- -- Diagnostics
                -- map('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')
                -- map('n', '[d', '<cmd>hua vim.diagnostic.goto_prev()<cr>')
                -- map('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>')
            end)

            require('mason-lspconfig').setup({
                ensure_installed = {
                    "lua_ls",
                    "gopls", "templ",
                    "rust_analyzer",
                    "tsserver",
                    "htmx", "html",
                    "jdtls",
                },
                handlers = {
                    lsp_zero.default_setup,
                    lua_ls = function()
                        -- (Optional) Configure lua language server for neovim
                        local config = lsp_zero.nvim_lua_ls()


                        config.on_attach = function(client, bufnr)
                            if client.server_capabilities.inlayHintProvider then
                                vim.lsp.inlay_hint.enable(bufnr, true)
                            end
                        end
                        config.settings = {
                            Lua = {
                                hint = {
                                    enable = true,
                                },
                                completion = {
                                    callSnippet = "Replace"
                                },
                                workspace = { checkThirdParty = false },
                                telemetry = { enable = false },
                            },
                        }
                        require('lspconfig').lua_ls.setup(config)
                    end,
                    jdtls = lsp_zero.noop,
                }
            })
        end
    },
}
