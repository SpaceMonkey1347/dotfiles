
-- REF: https://www.reddit.com/r/neovim/comments/15pvwk6/adding_custom_snippets_with_lspzero_not_working/

-- LSP SECTION
local lsp_zero = require("lsp-zero").preset({
    name = "recommended",
})

-- lsp_zero.preset('recommended')

lsp_zero.on_attach(function(client, bufnr)
    local nmap = function(keys, func, desc)
        if desc then
            desc = "LSP: " .. desc
        end

        vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
    end

    nmap("gd",          vim.lsp.buf.definition,     "Goto Definition")
    nmap("gD",          vim.lsp.buf.declaration,    "Goto Declaration")
    nmap("gi",          vim.lsp.buf.implementation, "Goto Implementation")
    nmap("K",           vim.lsp.buf.hover,          "Hover Documentation")
    nmap("<A-k>",       vim.lsp.buf.signature_help, "Hover Signature")
    nmap("<leader>vc",  vim.lsp.buf.code_action,    "Code Action")
    nmap("<leader>vr",  vim.lsp.buf.references,     "References")
    nmap("<leader>vn",  vim.lsp.buf.rename,         "Rename")
    nmap("<leader>vd",  vim.diagnostic.open_float,  "Hover Diagnostic")
    nmap("]d",          vim.diagnostic.goto_next,   "Goto Next Diagnostic")
    nmap("[d",          vim.diagnostic.goto_prev,   "Goto Prev Diagnostic")
end)

require("mason").setup({})
require("mason-lspconfig").setup({
    ensure_installed = { -- LSP servers
        "clangd",
        "lua_ls",
        "tsserver",
        "cssls",
        "eslint",
        "rust_analyzer",
        "pyright",
        "emmet_ls",
    },
    automatic_installation = true,

    handlers = {
        lsp_zero.default_setup,
        lua_ls = function()
            local lua_opts = lsp_zero.nvim_lua_ls()
            require("lspconfig").lua_ls.setup(lua_opts)
        end,
    }
})

lsp_zero.setup()

-- CMP SECTION
local cmp = require("cmp")
local cmp_action = require("lsp-zero").cmp_action()
local cmp_select = { behavior = cmp.SelectBehavior.Select }

local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

ls.add_snippets("all", {
    s("ternary", {
        -- equivalent to "${1:cond} ? ${2:then} : ${3:else}"
        i(1, "cond"), t(" ? "), i(2, "then"), t(" : "), i(3, "else")
    })
})

ls.add_snippets("lua", {
    s("ternary", {
        i(1, "cond"), t(" and "), i(2, "then"), t(" or "), i(3, "else")
    })
})

-- REF: https://learn.microsoft.com/en-us/cpp/c-language/cpp-integer-limits?view=msvc-170
ls.add_snippets("c", {
    -- bytes in smallest variable that's not a bit field
    s({
        trig = "maxcharbit",
        dscr= "CHAR_BIT",
    }, {
        t("8"),
    }),

    -- signed char
    s({
        trig = "minschar",
        dscr= "SCHAR_MIN",
    }, {
        t("-128"),
    }),
    s({
        trig = "maxschar",
        dscr= "SCHAR_MAX",
    },
    {
        t("127"),
    }),

    -- unsigned char
    s({
        trig = "maxuchar",
        dscr= "UCHAR_MAX",
    }, { -- todo convert to choice
        t("255 (0xff)"),
    }),

    -- char
    s({
        trig = "minchar",
        dscr= "CHAR_MIN",
    }, {
        t("-128"),
    }),
    s({
        trig = "maxchar",
        dscr= "CHAR_MAX",
    }, {
        t("127"),
    }),

    -- max bytes in multibyte character
    s({
        trig = "maxmblen",
        dscr= "MB_LEN_MAX",
    }, {
        t("5"),
    }),

    -- short
    s({
        trig = "minshrt",
        dscr= "SHRT_MIN",
    }, {
        t("-32768"),
    }),
    s({
        trig = "maxshrt",
        dscr= "SHRT_MAX",
    }, {
        t("32767"),
    }),

    -- unsigned short
    s({
        trig = "maxushrt",
        dscr= "USHRT_MAX",
    }, {
        t("65535"),
    }),

    -- int
    s({
        trig = "minint",
        dscr= "INT_MIN",
    }, {
        t("-2147483647 - 1"),
    }),
    s({
        trig = "maxint",
        dscr= "INT_MAX",
    }, {
        t("2147483647"),
    }),

    -- unsigned int
    s({
        trig = "maxuint",
        dscr= "UINT_MAX",
    }, {
        t("4294967295 (0xffffffff)"),
    }),

    -- long
    s({
        trig = "minlong",
        dscr= "LONG_MIN",
    }, {
        t("-2147483647 - 1"),
    }),
    s({
        trig = "maxlong",
        dscr= "LONG_MAX",
    }, {
        t("2147483647"),
    }),

    -- unsigned long
    s({
        trig = "maxulong",
        dscr= "ULONG_MAX",
    }, {
        t("4294967295 (0xffffffff)"),
    }),

    -- long long
    s({
        trig = "minllong",
        dscr= "LLONG_MIN",
    }, {
        t("-9_223_372_036_854_775_807 - 1"),
    }),
    s({
        trig = "maxllong",
        dscr= "LLONG_MAX",
    }, {
        t("9_223_372_036_854_775_807"),
    }),

    -- unsigned long long
    s({
        trig = "maxullong",
        dscr= "ULLONG_MAX",
    }, {
        t("18_446_744_073_709_551_615 (0xffffffffffffffff)"),
    }),
})

require("luasnip.loaders.from_vscode").lazy_load()

-- diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] =
    vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        underline = false,
    })

cmp.setup({
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    sources = {
        { name = "luasnip", option = { show_autosnippets = true } },
        { name = "nvim_lsp" },
        { name = "nvim_lua" },
        { name = "buffer" },
        { name = "path" },
        { name = "nvim_lsp_signature_help" },
    },
    snippet = {
        expand = function(args)
            require "luasnip".lsp_expand(args.body)
        end
    },
    formatting = lsp_zero.cmp_format(),

    -- NOTE: edit
    preselect = "item",
    completion = {
        completeopt = "menu,menuone,noinsert"
    },

    mapping = cmp.mapping.preset.insert({
        -- Navigate between snippets
        ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
        ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),

        -- Scroll up and down in the completion documentation
        ["<C-u>"] = cmp.mapping.scroll_docs(-4),
        ["<C-d>"] = cmp.mapping.scroll_docs(4),

        -- trigger completion menu
        ["<C-Space>"] = cmp.mapping.complete(),
        -- abort completion
        ['<C-e>'] = cmp.mapping.abort(),
        -- confirm completion
        ["<CR>"] = cmp.mapping.confirm({ select = true }),

        -- Navigate between snippet placeholder (insert mode)
        ["<C-b>"] = cmp_action.luasnip_jump_backward(),
        ["<C-f>"] = cmp_action.luasnip_jump_forward(),
    }),
})

