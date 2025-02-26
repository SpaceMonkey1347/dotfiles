require(CORE_PATH .. ".globals")
require(CORE_PATH .. ".utils")
require(CORE_PATH .. ".options")
require(CORE_PATH .. ".autocmds")

local restore_view = vim.fn.stdpath("config") .. "/lua/domo/core/restore_view.vim"
vim.cmd.source(restore_view)

