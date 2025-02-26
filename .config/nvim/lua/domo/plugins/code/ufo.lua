-- code folds
return {
    "kevinhwang91/nvim-ufo",
    dependencies = "kevinhwang91/promise-async",

    init = function ()
        vim.o.foldcolumn = "1"
        vim.o.foldlevel = 99
        vim.opt.foldlevelstart = 99 -- fold level when entering buffer
        vim.opt.foldenable = true -- toggle with "zi"
    end,

    opts = function ()
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities.textDocument.foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true
        }
        local language_servers = require("lspconfig").util.available_servers() -- or list servers manually like {'gopls', 'clangd'}
        for _, ls in ipairs(language_servers) do
            require('lspconfig')[ls].setup({
                capabilities = capabilities
                -- you can add other fields for setting up lsp server in this table
            })
        end
    end
}

