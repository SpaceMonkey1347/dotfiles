vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrw = 1

-- Tab Settinvim.g.
vim.o.tabstop = 4 -- A TAB character looks like 4 spaces
vim.o.softtabstop = 4 -- spaces inserted instead of a TAB character
vim.o.shiftwidth = 4 -- spaces inserted when indenting
vim.o.expandtab = true -- Pressing TAB inserts spaces instead of TAB character

vim.opt.smartindent = true

vim.opt.autoread = true -- update buffer when chanvim.g.d outside neovim
-- vim.opt.autochdir = true -- set working directory to parent of buffer

vim.opt.laststatus = 3 -- when to display statusline
-- vim.opt.winbar = "%=%m%f" -- `%m` for save status, `%f` for filename
vim.opt.showcmd = true -- n mode keys and v mode selection size

vim.opt.cursorline = true -- hilight cursorline
vim.opt.wrap = false -- line wrap
vim.opt.sidescroll = 20

vim.opt.scrolloff = 8 -- curser 8 lines from top or bottom of file
-- show listchars
vim.opt.list = false
vim.opt.listchars:prepend({ eol='↵',trail='~',tab='>-',nbsp='␣' })

-- Numbers
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.numberwidth = 2
vim.opt.ruler = true -- show cursor pos (line, column)

-- on search '/term'
vim.opt.hlsearch = false
vim.opt.incsearch = true -- hilight while writing /search term

vim.opt.termguicolors = true -- 24-bit RGB

vim.opt.updatetime = 50 -- fast updatetime

vim.opt.signcolumn = "yes" -- errors and whatnot column left of line numbers
vim.opt.isfname:append("@-@")

vim.opt.colorcolumn="80"

-- TODO: rename undo file on BufFilePre or BufFilePost
-- for undotree to have long running undos
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- code folding (now handled by ufo)
-- vim.o.foldmethod = "expr"
-- vim.o.foldexpr = "nvim_treesitter#foldexpr()"
-- vim.o.foldcolumn = "1"
-- vim.o.foldlevel = 20
-- vim.opt.foldlevelstart = 99 -- fold level when entering buffer
-- vim.opt.foldenable = true -- toggle with "zi"
-- vim.opt.fillchars = {
--   foldopen = "",
--   foldclose = "",
--   fold = " ",
--   foldsep = " ",
--   diff = "╱",
--   eob = " ",
-- }

-- set viewoptions=cursor,folds,slash,unix
vim.opt.viewoptions = "cursor,folds,slash,unix"

