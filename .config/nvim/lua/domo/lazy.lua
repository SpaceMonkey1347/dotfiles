local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    { import = PLUGINS_PATH .. ".ui" },
    { import = PLUGINS_PATH .. ".code" },
    { import = PLUGINS_PATH .. ".misc" },
    { import = PLUGINS_PATH .. ".debug" },
},
{ -- opts
    dev = {
        path = "~/.config/nvim/local_plugins"
    }
})
