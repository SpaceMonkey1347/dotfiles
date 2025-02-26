return {
    "folke/zen-mode.nvim",
    event = "VeryLazy",
    init = function ()
        require(UTILS_PATH).load_mappings "zen_mode"
    end
}

