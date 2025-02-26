return {
    "eandrju/cellular-automaton.nvim",
    cmd = {
        "CellularAutomaton",
    },
    init = function ()
        require(UTILS_PATH).load_mappings "cellular_automaton"
    end
}

