-- colorscheme
return {
    "navarasu/onedark.nvim",
    init = function()
        require("onedark").load()
    end,
    opts = {
        style = 'darker',
        code_style = {
            comments = 'italic',
            keywords = 'none',
            functions = 'none',
            strings = 'none',
            variables = 'none'
        },
    },
}

