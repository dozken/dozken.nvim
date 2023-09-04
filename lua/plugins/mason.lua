return {
        "williamboman/mason.nvim",
        cmd = "Mason",
        keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
        build = ":MasonUpdate",
        dependencies = {
                "williamboman/mason-lspconfig.nvim",
        },
        opts = {
                ensure_installed = {
                        "stylua",
                        "shfmt",
                        "eslint-lsp",
                        "js-debug-adapter",
                        "prettier",
                        "typescript-language-server"
                },
        },
        ---@param opts MasonSettings | {ensure_installed: string[]}
        config = function(_, opts)
                -- import mason
                local mason = require("mason")

                -- import mason-lspconfig
                local mason_lspconfig = require("mason-lspconfig")

                -- enable mason and configure icons
                mason.setup({
                        ui = {
                                icons = {
                                        package_installed = "✓",
                                        package_pending = "➜",
                                        package_uninstalled = "✗"
                                }
                        }
                })

                mason_lspconfig.setup({
                        -- list of servers for mason to install
                        ensure_installed = opts.ensure_installed,
                        -- auto-install configured servers (with lspconfig)
                        automatic_installation = true, -- not the same as ensure_installed
                })
        end,
}
