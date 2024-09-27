vim.api.nvim_create_augroup('bufcheck', { clear = true })

-- remove new-line auto-comments
vim.api.nvim_create_autocmd("BufEnter", {
    group    = 'bufcheck',
    callback = function()
        vim.opt.formatoptions = vim.opt.formatoptions - { "c","r","o" }
    end,
})

-- highlight yanks
vim.api.nvim_create_autocmd('TextYankPost', {
    group    = 'bufcheck',
    pattern  = '*',
    callback = function() vim.highlight.on_yank{timeout=200} end
})

-- start terminal in insert mode
vim.api.nvim_create_autocmd({'BufEnter'}, {
    group    = 'bufcheck',
    pattern = "term://*",
    callback = function ()
        vim.cmd.startinsert()
    end,
})

-- execute the command under the cursor then re-open command-line window  REF: :help command-line
vim.api.nvim_create_autocmd('CmdwinEnter', {
    group    = 'bufcheck',
    pattern = '*',
    command = 'map <buffer> <F5> <CR>q:'
})

-- override <C-c> (set to save file) to default (exit cmd) in the cmdline-window
vim.api.nvim_create_autocmd('CmdwinEnter', {
    group    = 'bufcheck',
    pattern = '*',
    command = 'map <buffer> <C-c> <C-c>',
})

