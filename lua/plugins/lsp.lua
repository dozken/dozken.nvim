-- lsp_setup.lua

local format_is_enabled = false
vim.api.nvim_create_user_command('KickstartFormatToggle', function()
    format_is_enabled = not format_is_enabled
    print('Setting autoformatting to: ' .. tostring(format_is_enabled))
end, {})

local _augroups = {}
local get_augroup = function(client)
    if not _augroups[client.id] then
        local group_name = 'kickstart-lsp-format-' .. client.name
        local id = vim.api.nvim_create_augroup(group_name, { clear = true })
        _augroups[client.id] = id
    end

    return _augroups[client.id]
end

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('kickstart-lsp-attach-format', { clear = true }),
    callback = function(args)
        local client_id = args.data.client_id
        local client = vim.lsp.get_client_by_id(client_id)
        local bufnr = args.buf
        if not client.server_capabilities.documentFormattingProvider then
            return
        end
        if client.name == 'tsserver' then
            return
        end

        vim.api.nvim_create_autocmd('BufWritePre', {
            group = get_augroup(client),
            buffer = bufnr,
            callback = function()
                if not format_is_enabled then
                    return
                end
                vim.lsp.buf.format {
                    async = false,
                    filter = function(c)
                        return c.id == client.id
                    end,
                }
            end,
        })
    end,
})

local on_attach = function(client, bufnr)
    if client.name == "gopls" then
        if not client.server_capabilities.semanticTokensProvider then
            local semantic = client.config.capabilities.textDocument.semanticTokens
            client.server_capabilities.semanticTokensProvider = {
                full = true,
                legend = {
                    tokenTypes = semantic.tokenTypes,
                    tokenModifiers = semantic.tokenModifiers,
                },
                range = true,
            }
        end
    end

    local nmap = function(keys, func, desc)
        if desc then
            desc = 'LSP: ' .. desc
        end
        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
    end

    nmap('<leader>rn', vim.lsp.buf.rename, 'Rename')
    nmap('<leader>ca', vim.lsp.buf.code_action, 'Code Action')
    nmap('gd', require('telescope.builtin').lsp_definitions, 'Goto Definition')
    nmap('gr', require('telescope.builtin').lsp_references, 'Goto References')
    nmap('gI', require('telescope.builtin').lsp_implementations, 'Goto Implementation')
    nmap('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type Definition')
    nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, 'Document Symbols')
    nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Workspace Symbols')
    nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
    nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')
    nmap('gD', vim.lsp.buf.declaration, 'Goto Declaration')
    nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, 'Workspace Add Folder')
    nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, 'Workspace Remove Folder')
    nmap('<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, 'Workspace List Folders')

    vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
        vim.lsp.buf.format()
    end, { desc = 'Format current buffer with LSP' })
end

return {
    {
        'neovim/nvim-lspconfig',
        event = { "BufRead", "BufNewFile", "BufWritePre" },
        dependencies = {
            { 'williamboman/mason.nvim', cmd = "Mason", config = true },
            { 'williamboman/mason-lspconfig.nvim' },
            { "j-hui/fidget.nvim", opts = { notification = { window = { winblend = 0 } } }},
            { 'folke/neodev.nvim', opts = {} },
        },
        opts = {
            servers = {
                lua_ls = {
                    Lua = {
                        completion = { callSnippet = "Replace" },
                        workspace = { checkThirdParty = false },
                        telemetry = { enable = false },
                    },
                },
                gopls = {
                    gofumpt = true,
                    codelenses = {
                        generate = true,
                        regenerate_cgo = true,
                        run_govulncheck = true,
                        test = true,
                        tidy = true,
                        upgrade_dependency = true,
                        vendor = true,
                    },
                    hints = {
                        assignVariableTypes = true,
                        compositeLiteralFields = true,
                        compositeLiteralTypes = true,
                        constantValues = true,
                        functionTypeParameters = true,
                        parameterNames = true,
                        rangeVariableTypes = true,
                    },
                    analyses = {
                        fieldalignment = true,
                        nilness = true,
                        unusedparams = true,
                        unusedwrite = true,
                        useany = true,
                    },
                    usePlaceholders = true,
                    completeUnimported = true,
                    staticcheck = true,
                    directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
                    semanticTokens = true,
                },
                templ = { filetypes = { "templ" } },
                rust_analyzer = {
                    cargo = {
                        allFeatures = true,
                        loadOutDirsFromCheck = true,
                        runBuildScripts = true,
                    },
                    checkOnSave = {
                        allFeatures = true,
                        command = "clippy",
                        extraArgs = { "--no-deps" },
                    },
                    procMacro = {
                        enable = true,
                        ignored = {
                            ["async-trait"] = { "async_trait" },
                            ["napi-derive"] = { "napi" },
                            ["async-recursion"] = { "async_recursion" },
                        },
                    },
                    excludeDirs = {
                        "_build",
                        ".dart_tool",
                        ".flatpak-builder",
                        ".git",
                        ".gitlab",
                        ".gitlab-ci",
                        ".gradle",
                        ".idea",
                        ".next",
                        ".project",
                        ".scannerwork",
                        ".settings",
                        ".venv",
                        "archetype-resources",
                        "bin",
                        "hooks",
                        "node_modules",
                        "po",
                        "screenshots",
                        "target"
                    }
                },
                tsserver = {},
                htmx = {},
                html = { filetypes = { 'html', 'twig', 'hbs', "templ" } },
                jdtls = {}
            }
        },
        config = function(_, opts)
            require('which-key').register({
                ['<leader>c'] = { name = 'Code', _ = 'which_key_ignore' },
                ['<leader>d'] = { name = 'Document', _ = 'which_key_ignore' },
                ['<leader>w'] = { name = 'Workspace', _ = 'which_key_ignore' },
                ['<leader>r'] = { name = 'Refactor', _ = 'which_key_ignore' },
                ['<leader>x'] = { name = 'Quickfix', _ = 'which_key_ignore' },
            })

            local servers = opts.servers
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

            require('mason-lspconfig').setup({
                ensure_installed = vim.tbl_keys(servers),
                handlers = {
                    function(server_name)
                        if server_name == 'jdtls' then return end
                        local config = {
                            capabilities = capabilities,
                            on_attach = on_attach,
                            settings = servers[server_name],
                            filetypes = (servers[server_name] or {}).filetypes,
                        }
                        require('lspconfig')[server_name].setup(config)
                    end,
                },
            })
        end
    }
}
