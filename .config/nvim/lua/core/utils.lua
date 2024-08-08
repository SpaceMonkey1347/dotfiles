local merge_tb = vim.tbl_deep_extend

local M = {}
-- reload mappings once on :source in lua/core/mappings.lua
M.mappings_loaded_flag = false
local loaded_sections = {}

local function call_vimscript(vim_code)
    -- execute vim functions and commands
    if vim_code then
        if type(vim_code) == "table" then
            for _, value in pairs(vim_code) do
                call_vimscript(value)
            end
        elseif type(vim_code) == "function" then
            vim_code()
        elseif type(vim_code) == "string" then
            vim.cmd(vim_code)
        end
    end
end

local function call_lua(lua_code)
    -- execute lua functions and commands
    if lua_code then
        if type(lua_code) == "table" then
            for _, value in pairs(lua_code) do
                call_lua(value)
            end
        elseif type(lua_code) == "function" then
            lua_code()
        elseif type(lua_code) == "string" then
            -- ensure string is interpreted as lua
            if string.sub(lua_code, 1, 4) == "lua " then
                vim.cmd(lua_code)
            else
                vim.cmd("lua " .. lua_code)
            end
        end
    end
end

local function set_section_map(section_values, mapping_opts)
    -- ensure plugin is loaded
    if section_values.plugin then
        return
    end
    call_vimscript(section_values.vimscript)
    section_values.vimscript = nil
    call_lua(section_values.lua)
    section_values.lua = nil
    -- get mapping opts for entire section
    local section_opts
    if section_values.opts then
        section_opts = section_values.opts
        section_values.opts = nil
    end
    -- set mappings
    for mode, mode_values in pairs(section_values) do
        for keybind, mapping_info in pairs(mode_values) do

            local opts = merge_tb("force", mapping_opts or {}, section_opts or {}, mapping_info.opts or {})
            opts.desc = mapping_info[2]

            vim.keymap.set(mode, keybind, mapping_info[1], opts)
        end
    end
end

M.load_mappings = function (section, mapping_opt)
    vim.schedule(function()
        local mappings = require("core.mappings")
        M.mappings_loaded_flag = true

        if type(section) == "string" then
            mappings[section]["plugin"] = nil
            mappings = {}
        end

        for name, sect in pairs(mappings) do
            if not sect.plugin then
                if type(name) == "number" then
                    table.insert(loaded_sections, section)
                else
                    table.insert(loaded_sections, name)
                end
            end
            set_section_map(sect, mapping_opt)
        end
    end)
end

M.reload_mappings = function (section, mapping_opt)
    M.mappings_loaded_flag = false
    local mapping_path = vim.api.nvim_get_runtime_file("lua/core/mappings.lua", false)[1]
    local mappings = dofile(mapping_path)

    if type(section) == "string" then
        mappings[section]["plugin"] = nil
        mappings = { mappings[section] }
    end

    for _, sect in pairs(loaded_sections) do
        set_section_map(mappings[sect], mapping_opt)
    end
end

M.vim_opt_toggle = function (opt, on, off, name)
    local message = name
    if vim.opt[opt]:get() == off then
        vim.opt[opt] = on
        message = message .. " Enabled"
    else
        vim.opt[opt] = off
        message = message .. " Disabled"
    end
    vim.notify(message)
end

return M

