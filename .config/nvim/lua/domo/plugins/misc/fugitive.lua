-- git
return {
    "tpope/vim-fugitive",
    init = function ()
        require(UTILS_PATH).load_mappings "fugitive"
    end
}

