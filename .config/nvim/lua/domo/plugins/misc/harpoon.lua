return {
    "theprimeagen/harpoon",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    init = function ()
        require(UTILS_PATH).load_mappings "harpoon"
    end
}

