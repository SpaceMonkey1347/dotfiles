P = function(v)
  print(vim.inspect(v))
end

RELOAD = function (...)
  return require("plenary.reload").reload_module(...)
end

R = function(name)
  RELOAD(name)
  return require(name)
end

UPDATE_LAZY = function ()
    vim.cmd("Lazy update")
end

UPDATE_TREESITTER = function ()
    vim.cmd("TSUpdate")
end

UPDATE_MASON = function ()
    if not vim.fn.exists(":MasonInstallAll") then
        vim.api.nvim_create_user_command("MasonInstallAll", function()
            vim.cmd("MasonInstall " .. table.concat(require("plugins.configs.mason").ensure_installed, " "))
        end, {})
    end
    vim.cmd("MasonInstallAll")
end

UPDATE = function ()
    UPDATE_LAZY()
    UPDATE_TREESITTER()
    UPDATE_MASON()
end

RELOAD_MAPPINGS = function ()
    require(UTILS_PATH).reload_mappings()
end

CONFIG_PATH = "domo"
CORE_PATH = "domo.core"
PLUGINS_PATH = "domo.plugins"
UTILS_PATH = "domo.core.utils"
MAPPINGS_PATH = "domo.core.mappings"
MAPPINGS_PATH_2 = "lua/core/mappings.lua"

