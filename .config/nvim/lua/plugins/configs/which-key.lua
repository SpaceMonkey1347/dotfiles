local M = {}

M.init = function ()
    vim.o.timeout = true
    vim.o.timeoutlen = 500
end

M.config = function ()
    local wk = require("which-key")

    wk.add({
        {
            mode = { "n" },
            { "<leader><leader>", group = "clipboard" },
            { "<leader>a", group = "cellular_automaton" },
            { "<leader>b", group = "buffer" },
            { "<leader>c", group = "cd/e[dit]" },
            { "<leader>cd", group = ":cd" },
            { "<leader>cdn", group = "nvims" },
            { "<leader>ce", group = ":e[dit]" },
            { "<leader>cen", group = "nvims" },
            { "<leader>d", group = "debug" },
            { "<leader>dr", group = "breakpoint" },
            { "<leader>ds", group = "step" },
            { "<leader>f", group = "file" },
            { "<leader>h", group = "harpoon" },
            { "<leader>l", group = "dadbod-ui" },
            { "<leader>q", group = "macros" },
            { "<leader>t", group = "toggle" },
            { "<leader>v", group = "lsp" },
            { "[t", group = "Prev todo comment" },
            { "]t", group = "Next todo comment" },
            { ";", group = "search and replace"},
        },
        {
            mode = { "x" },
            { "<leader>", group = "clipboard" },
            { "<leader><leader>", group = "system clipboard" },
        },
})
end

return M

