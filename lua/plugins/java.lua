return {
    'mfussenegger/nvim-jdtls',
    ft = "java",
    dependencies = {
        { 'williamboman/mason-lspconfig.nvim' },
    },
    config = function()
        -- local lsp_zero = require('lsp-zero')
        require('mason-lspconfig').setup({
            ensure_installed = {
                "jdtls",
            },
            handlers = {
                -- lsp_zero.default_setup,
                jdtls = function() end
            }
        })
    end
}
