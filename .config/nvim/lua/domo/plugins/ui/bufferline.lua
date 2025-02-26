-- tabs
return {
    "akinsho/bufferline.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    event = "VeryLazy",
    init = function ()
        require(UTILS_PATH).load_mappings "bufferline"
    end,
    opts = {
        options = {
            mode = "tabs"
        }
    },
}

