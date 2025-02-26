return {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
    init = function ()
        require(UTILS_PATH).load_mappings "telescope_file_browser"
    end,
    config = function (_, _)
        require("telescope").load_extension "file_browser"
    end,
}

