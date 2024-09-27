local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node

vim.keymap.set({"i", "s"}, "<C-h>",
            function ()
                if ls.choice_active() then
                    ls.change_choice(-1)
                end
            end)
vim.keymap.set({"i", "s"}, "<C-l>",
            function ()
                if ls.choice_active() then
                    ls.change_choice(1)
                end
            end)

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

ls.add_snippets("all", {
    s({
        trig = "maxcharbit",
        dscr = "CHAR_BIT <limits.h>\n"..
        "Number of bits in the smallest variable that is not a bit field.\n"..
        "Value = 8",
    }, {
        t("8"),
    }),

    -- signed char
    s({
        trig = "minschar",
        dscr = "SCHAR_MIN <limits.h>\n"..
        "Minimum value for a variable of type signed char.\n"..
        "Value = -128 (0xffffff80)",
    }, {
        c(1, {
            t("-128"),
            t("0xffffff80"),
        }),
    }),
    s({
        trig = "maxschar",
        dscr = "SCHAR_MAX <limits.h>\n"..
        "Maximum value for a variable of type signed char.\n"..
        "Value = 127 (0x7f)",
    },
    {
        c(1, {
            t("127"),
            t("0x7f"),
        }),
    }),

    -- unsigned char
    s({
        trig = "maxuchar",
        dscr = "UCHAR_MAX <limits.h>\n"..
        "Maximum value for a variable of type unsigned char.\n"..
        "Value = 255 (0xff)",
    }, {
        c(1, {
            t("255"),
            t("0xff"),
        })
    }),

    -- char
    s({
        trig = "minchar",
        dscr = "CHAR_MIN <limits.h>\n"..
        "Minimum value for a variable of type char.\n"..
        "Value = -128 (0xffffff80)",
    }, {
        c(1, {
            t("-128"),
            t("0xffffff80"),
        }),
    }),
    s({
        trig = "maxchar",
        dscr = "CHAR_MAX <limits.h>\n"..
        "Maximum value for a variable of type char.\n"..
        "Value = 127 (0x7f)",
    }, {
        c(1, {
            t("127"),
            t("0x7f"),
        }),
    }),

    -- max bytes in multibyte character
    s({
        trig = "maxmblen",
        dscr = "MB_LEN_MAX <limits.h>\n"..
        "Maximum number of bytes in a multibyte character.\n"..
        "Value = 16",
    }, {
        t("16"),
    }),

    -- short
    s({
        trig = "minshrt",
        dscr = "SHRT_MIN <limits.h>\n"..
        "Minimum value for a variable of type short.\n"..
        "Value = -32768 (0xffff8000)",
    }, {
        c(1, {
            t("-32768"),
            t("0xffff8000"),
        }),
    }),
    s({
        trig = "maxshrt",
        dscr = "SHRT_MAX <limits.h>\n"..
        "Maximum value for a variable of type short.\n"..
        "Value = 32767 (0x7fff)",
    }, {
        c(1, {
            t("32767"),
            t("0x7fff"),
        }),
    }),

    -- unsigned short
    s({
        trig = "maxushrt",
        dscr = "USHRT_MAX <limits.h>\n"..
        "Maximum value for a variable of type unsigned short.\n"..
        "Value = 65535 (0xffff)",
    }, {
        c(1, {
            t("65535"),
            t("0xffff"),
        }),
    }),

    -- int
    s({
        trig = "minint",
        dscr = "INT_MIN <limits.h>\n"..
        "Minimum value for a variable of type int.\n"..
        "Value = -2147483648 (0x80000000)",
    }, {
        c(1, {
            t("-2147483648"),
            t("0x80000000"),
        }),
    }),
    s({
        trig = "maxint",
        dscr = "INT_MAX <limits.h>\n"..
        "Maximum value for a variable of type int.\n"..
        "Value = 2147483647 (0x7fffffff)",
    }, {
        c(1, {
            t("2147483647"),
            t("0x7fffffff"),
        }),
    }),

    -- unsigned int
    s({
        trig = "maxuint",
        dscr = "UINT_MAX <limits.h>\n"..
        "Maximum value for a variable of type unsigned int.\n"..
        "Value = 4294967295U (0xffffffff)",
    }, {
        c(1, {
            t("4294967295U"),
            t("0xffffffff"),
        })
    }),

    -- long
    s({
        trig = "minlong",
        dscr = "LONG_MIN <limits.h>\n"..
        "Minimum value for a variable of type long.\n"..
        "Value = -9223372036854775808L (0x8000000000000000)",
    }, {
        c(1, {
            t("-9223372036854775808L"),
            t("0x8000000000000000"),
        }),
    }),
    s({
        trig = "maxlong",
        dscr = "LONG_MAX <limits.h>\n"..
        "Maximum value for a variable of type long.\n"..
        "Value = 9223372036854775807L (0x7fffffffffffffff)",
    }, {
        c(1, {
            t("9223372036854775807L"),
            t("0x7fffffffffffffff"),
        }),
    }),

    -- unsigned long
    s({
        trig = "maxulong",
        dscr = "ULONG_MAX <limits.h>\n"..
        "Maximum value for a variable of type unsigned long.\n"..
        "Value = 18446744073709551615UL (0xffffffffffffffff)",
    }, {
        c(1, {
            t("18446744073709551615UL"),
            t("0xffffffffffffffff"),
        }),
    }),

    -- long long
    s({
        trig = "minllong",
        dscr = "LLONG_MIN <limits.h>\n"..
        "Minimum value for a variable of type long long.\n"..
        "Value = -9223372036854775808LL (0x8000000000000000)",
    }, {
        c(1, {
            t("-9223372036854775808LL"),
            t("0x8000000000000000"),
        }),
    }),
    s({
        trig = "maxllong",
        dscr = "LLONG_MAX <limits.h>\n"..
        "Maximum value for a variable of type long long.\n"..
        "Value = 9223372036854775807LL (0x7fffffffffffffff)",
    }, {
        c(1, {
            t("9223372036854775807LL"),
            t("0x7fffffffffffffff"),
        }),
    }),

    -- unsigned long long
    s({
        trig = "maxullong",
        dscr = "ULLONG_MAX <limits.h>\n"..
        "Maximum value for a variable of type unsigned long long.\n"..
        "Value = 18446744073709551615ULL (0xffffffffffffffff)",
    }, {
        c(1, {
            t("18446744073709551615ULL"),
            t("0xffffffffffffffff"),
        }),
    }),
})

