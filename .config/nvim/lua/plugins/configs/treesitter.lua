local opts = {
    ensure_installed = { -- parsers
        "query",
        "vim",
        "vimdoc",
        "lua",
        "html",
        "css",
        "javascript",
        "typescript",
        "tsx",
        "c",
        -- "cpp",
        "markdown",
        "markdown_inline",
        "python",
    },
    sync_install = true,
    highlight = {
        enable = true,
        use_languagetree = true,
    },
    indent = { enable = true },
}

return opts

