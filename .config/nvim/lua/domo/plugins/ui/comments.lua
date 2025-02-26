-- comments
return {
    "numToStr/Comment.nvim",
    init = function()
        require(UTILS_PATH).load_mappings "comment"
    end,
    lazy = false,
}

