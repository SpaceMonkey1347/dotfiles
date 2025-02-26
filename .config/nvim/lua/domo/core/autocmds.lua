vim.api.nvim_create_augroup("bufcheck", { clear = true })

-- remove new-line auto-comments
vim.api.nvim_create_autocmd("BufEnter", {
    group    = "bufcheck",
    callback = function()
        vim.opt.formatoptions = vim.opt.formatoptions - { "c","r","o" }
    end,
})

-- highlight yanks
vim.api.nvim_create_autocmd("TextYankPost", {
    group    = "bufcheck",
    pattern  = "*",
    callback = function() vim.highlight.on_yank{timeout=200} end
})

-- start terminal in insert mode
vim.api.nvim_create_autocmd({"BufEnter"}, {
    group    = "bufcheck",
    pattern = "term://*",
    callback = function ()
        vim.cmd.startinsert()
    end,
})

-- execute the command under the cursor then re-open command-line window  REF: :help command-line
vim.api.nvim_create_autocmd("CmdwinEnter", {
    group    = "bufcheck",
    pattern = "*",
    command = "map <buffer> <F5> <CR>q:"
})

-- override <C-c> (set to save file) to default (exit cmd) in the cmdline-window
vim.api.nvim_create_autocmd("CmdwinEnter", {
    group    = "bufcheck",
    pattern = "*",
    command = "map <buffer> <C-c> <C-c>",
})

vim.api.nvim_create_augroup("bigfile", { clear = true})

vim.filetype.add({
  pattern = {
    [".*"] = {
      function(path, buf)
        return vim.bo[buf].filetype ~= "bigfile" and path and vim.fn.getfsize(path) > vim.g.bigfile_size and "bigfile"
          or nil
      end,
    },
  },
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  group = "bigfile",
  pattern = "bigfile",
  callback = function(ev)
    -- vim.b.minianimate_disable = true
    vim.schedule(function()
      vim.bo[ev.buf].syntax = vim.filetype.match({ buf = ev.buf }) or ""
    end)
  end,
})

