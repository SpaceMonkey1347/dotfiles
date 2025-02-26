return {
    "mfussenegger/nvim-dap",
    config = function(_, _)
        require(UTILS_PATH).load_mappings "dap"
    end
}

