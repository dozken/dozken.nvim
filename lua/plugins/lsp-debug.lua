return {
    'ThePrimeagen/lsp-debug-tools.nvim',
    config = function()
        local ldt = require('lsp-debug-tools')

        local config = {
            expected = {'html'},
            name = 'thymeleaf_ls',
            cmd = { '/Users/dozh/projects/thymeleaf_ls/target/debug/thymeleaf_ls' },
            root_dir = vim.fs.dirname(vim.fs.find({ 'pom.xml' }, { upward = true })[1]),
        }

        ldt.start(config)
    end

}
