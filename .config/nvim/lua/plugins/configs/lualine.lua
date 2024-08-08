-- local wc = require("wordcount")

return {
    options = {
        icons_enabled = true,
        theme = 'auto',
        component_separators = { left = '', right = ''},
        section_separators = { left = '', right = ''},
        disabled_filetypes = {
            statusline = {},
            winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = false,
        refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
        }
    },
    sections = {
        lualine_a = {{'filename', path = 1}},
        lualine_b = {'branch', 'diff', 'diagnostics'},
        lualine_c = {'mode'},
        lualine_x = {
            -- {wc.update},
            -- {wc.bytes,        color = {fg = "#ffffff"}},
            -- {wc.chars,        color = {fg = "#ffffff"}},
            -- {wc.words,        color = {fg = "#ffffff"}},
            -- {wc.cursor_bytes, color = {fg = "#ffffff"}},
            -- {wc.cursor_chars, color = {fg = "#ffffff"}},
            -- {wc.cursor_words, color = {fg = "#ffffff"}},
            -- {wc.visual_bytes, color = {fg = "#ffffff"}},
            -- {wc.visual_chars, color = {fg = "#ffffff"}},
            -- {wc.visual_words, color = {fg = "#ffffff"}},
            'encoding', 'fileformat', 'filetype'},
        lualine_y = {'progress'},
        lualine_z = {'location'}
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {}
}
