local opts = {
    size = function(term)
        if term.direction == "horizontal" then
            return 20
        elseif term.direction == "vertical" then
            -- return vim.o.columns * 0.4
            return 80
        end
    end,
    open_mapping = [[<C-\>]],
    on_open = function (t) vim.cmd.startinsert() end,
    start_in_insert = true,
    insert_mappings = true,
    close_on_exit = true,
    persist_size = true,
    direction = "float",
}

return opts

