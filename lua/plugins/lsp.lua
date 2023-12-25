-- Switch for controlling whether you want autoformatting.
--  Use :KickstartFormatToggle to toggle autoformatting on or off
local format_is_enabled = false
vim.api.nvim_create_user_command('KickstartFormatToggle', function()
    format_is_enabled = not format_is_enabled
    print('Setting autoformatting to: ' .. tostring(format_is_enabled))
end, {})

-- Create an augroup that is used for managing our formatting autocmds.
--      We need one augroup per client to make sure that multiple clients
--      can attach to the same buffer without interfering with each other.
local _augroups = {}
local get_augroup = function(client)
    if not _augroups[client.id] then
        local group_name = 'kickstart-lsp-format-' .. client.name
        local id = vim.api.nvim_create_augroup(group_name, { clear = true })
        _augroups[client.id] = id
    end

    return _augroups[client.id]
end

vim.filetype.add({
    extension = {
        templ = "templ",
    },
})

-- Whenever an LSP attaches to a buffer, we will run this function.
--
-- See `:help LspAttach` for more information about this autocmd event.
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('kickstart-lsp-attach-format', { clear = true }),
    -- This is where we attach the autoformatting for reasonable clients
    callback = function(args)
        local client_id = args.data.client_id
        local client = vim.lsp.get_client_by_id(client_id)
        local bufnr = args.buf

        -- Only attach to clients that support document formatting
        if not client.server_capabilities.documentFormattingProvider then
            return
        end

        -- Tsserver usually works poorly. Sorry you work with bad languages
        -- You can remove this line if you know what you're doing :)
        if client.name == 'tsserver' then
            return
        end

        -- Create an autocmd that will run *before* we save the buffer.
        --  Run the formatting command for the LSP that has just attached.
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


--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(client, bufnr)
    -- NOTE: Remember that lua is a real programming language, and as such it is possible
    -- to define small helper and utility functions so you don't have to repeat yourself
    -- many times.
    --
    -- In this case, we create a function that lets us more easily define mappings specific
    -- for LSP related items. It sets the mode, buffer and description for us each time.
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

    -- See `:help K` for why this keymap
    nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
    nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

    -- Lesser used LSP functionality
    nmap('gD', vim.lsp.buf.declaration, 'Goto Declaration')
    nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, 'Workspace Add Folder')
    nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, 'Workspace Remove Folder')
    nmap('<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, 'Workspace List Folders')

    -- Create a command `:Format` local to the LSP buffer
    vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
        vim.lsp.buf.format()
    end, { desc = 'Format current buffer with LSP' })



    -- if client.server_capabilities.inlayHintProvider then
    --     vim.lsp.inlay_hint.enable(bufnr, true)
    -- end
end

return {
    -- NOTE: This is where your plugins related to LSP can be installed.
    --  The configuration is done below. Search for lspconfig to find it below.
    {
        -- LSP Configuration & Plugins
        'neovim/nvim-lspconfig',
        event = { "BufRead", "BufNewFile", "BufWritePre" },
        dependencies = {
            -- Automatically install LSPs to stdpath for neovim
            {
                'williamboman/mason.nvim',
                cmd = "Mason",
                config = true
            },
            { 'williamboman/mason-lspconfig.nvim' },

            -- Useful status updates for LSP
            -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
            {
                "j-hui/fidget.nvim",
                opts = {
                    notification = {
                        window = {
                            winblend = 0
                        }
                    }
                },
            },
            --
            -- Additional lua configuration, makes nvim stuff amazing!
            { 'folke/neodev.nvim',                opts = {} },

        },
        opts = {
            servers = {
                lua_ls = {
                    Lua = {
                        completion = {
                            callSnippet = "Replace"
                        },
                        workspace = { checkThirdParty = false },
                        telemetry = { enable = false },
                    },
                },
                gopls = {},
                templ = {
                    filetypes = { "templ" }
                },
                rust_analyzer = {
                    cargo = {
                        allFeatures = true,
                        loadOutDirsFromCheck = true,
                        runBuildScripts = true,
                    },
                    -- Add clippy lints for Rust.
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
                -- htmx = {},
                -- html = { filetypes = { 'html', 'twig', 'hbs' } },
                jdtls = {
                    cmd = {
                        { vim.fn.exepath("jdtls"),
                            "--jvm-arg=" .. string.format("-javaagent:%s", vim.fn.expand "$MASON/share/jdtls/lombok.jar"),
                        }
                    }
                },
            }

        },
        config = function(_, opts)
            require('which-key').register({
                ['<leader>c'] = { name = 'Code', _ = 'which_key_ignore' },
                ['<leader>d'] = { name = 'Document', _ = 'which_key_ignore' },
                ['<leader>w'] = { name = 'Workspace', _ = 'which_key_ignore' },
                ['<leader>r'] = { name = 'Rename', _ = 'which_key_ignore' },
                ['<leader>x'] = { name = 'Quickfix', _ = 'which_key_ignore' },
            })
            local servers = opts.servers

            -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

            -- Ensure the servers above are installed
            local mason_lspconfig = require 'mason-lspconfig'

            mason_lspconfig.setup {
                ensure_installed = vim.tbl_keys(servers),
            }

            mason_lspconfig.setup_handlers {
                function(server_name)
                    local config = {
                        capabilities = capabilities,
                        on_attach = on_attach,
                        settings = servers[server_name],
                        filetypes = (servers[server_name] or {}).filetypes,
                    }

                    if servers[server_name] ~= nil and servers[server_name].cmd ~= nil then
                        config.cmd = servers[server_name].cmd
                    end

                    require('lspconfig')[server_name].setup(config)
                end,
            }
        end,
    },
}
