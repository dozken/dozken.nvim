return {
    'simrat39/rust-tools.nvim',
    enabled = false,
    ft = "rust",
    config = function()
        require('mason-lspconfig').setup({
            handlers = {
                rust_analyzer = function()
                    local rust_tools = require('rust-tools')
                    rust_tools.setup()
                end,
            }
        })
    end
}
