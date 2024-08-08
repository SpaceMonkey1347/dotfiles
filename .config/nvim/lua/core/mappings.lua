-- Cheat Sheet

-- NOTE: insert mode
-- <C-r> Insert the contents of a numbered or named register.

-- NOTE: folds
-- "zf" create fold
-- "zo" open fold
-- "zc" close fold
-- "zd" delete fold
-- "zD" delete folds recursively

-- NOTE: command-line
-- <C-f> open cmdline-window
-- <C-c> close command-line
-- <F5> custom autocommand, re-open command-line-window after executing command under cursor 

-- TODO: keep track of any default rhs current mappings override

local M = {}

local opts = { noremap = true, silent = true }

-- reload mappings once on :source
local file_sourced = require("core.utils").mappings_loaded_flag
if file_sourced then
    require("core.utils").reload_mappings()
else
    file_sourced = true
end


M.general = {
    i = {
        ["jk"] = { "<Esc>", "Escape insert mode", opts = { nowait = true }},

        ["<C-b>"] = { "<ESC>^i", "Goto beginning of line" },
        ["<C-e>"] = { "<End>", "Goto end of line" },

        ["<C-h>"] = { "<Left>", "Move left" },
        ["<C-l>"] = { "<Right>", "Move right" },
        ["<C-j>"] = { "<Down>", "Move down" },
        ["<C-k>"] = { "<Up>", "Move up" },

        ["<C-s>"] = { "<Cmd> w <CR>", "Save file" },
        ["<C-c>"] = { "<cmd> %y+ <CR>", "Copy whole file" },
    },

    n = {
        -- switch between windows
        ["<C-h>"] = { "<C-w>h", "Window left" },
        ["<C-l>"] = { "<C-w>l", "Window right" },
        ["<C-j>"] = { "<C-w>j", "Window down" },
        ["<C-k>"] = { "<C-w>k", "Window up" },

        -- Resize window using <shift> arrow keys
        ["<S-Up>"]    = { "<Cmd>resize +2<CR>",          "Resize up" },
        ["<S-Down>"]  = { "<Cmd>resize -2<CR>",          "Resize down" },
        ["<S-Left>"]  = { "<Cmd>vertical resize -2<CR>", "Resize left" },
        ["<S-Right>"] = { "<Cmd>vertical resize +2<CR>", "Resize right" },

        ["<C-s>"] = { "<Cmd> w <CR>", "Save file" },
        ["<C-c>"] = { "<cmd> %y+ <CR>", "Copy whole file" },

        ["<leader>s"] = { [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], "Globally rename" },

        ["<leader>qq"] = { "@", "Play macro" },

        ["<leader>O"] = { "O<Esc>", "New line above" },
        ["<leader>o"] = { "o<Esc>", "New line below" },

        [";;"] = { "q:i%s:::g<Left><Left><Left>" },
        [";'"] = { "q:i%s:::cg<Left><Left><Left><Left>" },

        ["c/"] = { "/\\c", "case insensitive search" },
    },

    v = {
        ["J"] = { ":m '>+1<CR>gv=gv", "Move selected lines down" },
        ["K"] = { ":m '<-2<CR>gv=gv", "Move selected lines up" },
        -- auto-captialize SQL CITE: https://softwareengineering.stackexchange.com/questions/69576/how-to-auto-format-and-auto-capitalize-sql-in-vim
        ["rp"] = { ":s/update\\|select\\|from\\|where\\|left join\\|inner join\\|group by\\|order by/\\U&/ge<cr><esc>" }
    },

    c = {
        ["<C-h>"] = { "<Left>" },
        ["<C-j>"] = { "<Down>" },
        ["<C-k>"] = { "<Up>" },
        ["<C-l>"] = { "<Right>" },
    }

}

M.modify = {
    n = {
        ["J"] = { "mzJ`z", "Center cursor on join"},
        ["<C-d>"] = { "<C-d>zz", "Center cursor on half-page jump down" },
        ["<C-u>"] = { "<C-u>zz", "Center cursor on half-page jump up" },
        ["n"] = { "nzzzv", "Center cursor on search next" },
        ["N"] = { "Nzzzv", "Center cursor on search prev" },

        ["<leader>gx"] = { "<Cmd> call HandleURL() <CR>", "Open Github shorthand URL in Browser" },

        -- Allow moving the cursor through wrapped lines with j, k, <Up> and <Down>
        -- CITE: http://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/
        -- empty mode is same as using <Cmd> :map
        -- also don't use g[j|k] when in operator pending mode, so it doesn't alter d, y or c behaviour

        ["j"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "Move down", opts = { expr = true } },
        ["k"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "Move up", opts = { expr = true } },
        ["<Up>"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "Move up", opts = { expr = true } },
        ["<Down>"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "Move down", opts = { expr = true } },
    },

}

M.clipboard = {
    n = {
        ['<leader><leader>y'] = { [["+y]],   "Yank into system clipboard" },
        ['<leader><leader>Y'] = { [["+Y]],   "Yank into system clipboard" },
        ['<leader><leader>p'] = { [["+p]],    "Put from system clipboard" },
        ['<leader><leader>P'] = { [["+P]],    "Put from system clipboard" },
        ['<leader><leader>d'] = { [["+d]], "Delete into system clipboard" },
        ['<leader><leader>D'] = { [["+D]], "Delete into system clipboard" },
        ['<leader><leader>c'] = { [["+c]], "Change into system clipboard" },
        ['<leader><leader>C'] = { [["+C]], "Change into system clipboard" },

        ['<leader><leader>x'] = { [["_d]], "Delete into void register" },
        ['<leader><leader>X'] = { [["_D]], "Delete into void register" },
        ['<leader><leader>v'] = { [["_c]], "Change into void register" },
        ['<leader><leader>V'] = { [["_C]], "Change into void register" },
    },

    x = {
        ["<leader><leader>y"] = { [["+y]], "Yank into system clipboard" },
        ["<leader><leader>Y"] = { [["+Y]], "Yank into system clipboard" },
        ['<leader><leader>p'] = { [["+p]], "Put from system clipboard" },
        ['<leader><leader>P'] = { [["+P]], "Put from system clipboard" },
        ['<leader><leader>d'] = { [["+d]], "Delete into system clipboard" },
        ['<leader><leader>D'] = { [["+D]], "Delete into system clipboard" },
        ['<leader><leader>c'] = { [["+c]], "Change into system clipboard" },
        ['<leader><leader>C'] = { [["+C]], "Change into system clipboard" },

        ["<leader>p"] = { [["_dp]], "don't copy highlighted text when pasting over" },
        ["<leader>P"] = { [["_dP]], "don't copy highlighted text when pasting over" },
        ['<leader>d'] = { [["_d]], "Delete into void register" },
        ['<leader>D'] = { [["_D]], "Delete into void register" },
        ['<leader>c'] = { [["_c]], "Change into void register" },
        ['<leader>C'] = { [["_C]], "Change into void register" },
    },
}
M.toggle = {
    n = {
        ["<leader>th"] = { ":nohlsearch<CR>", "Clear highlight search" },
        ["<leader>tH"] = { ":set hlsearch!<CR>", "Toggle highlight search" },
        ["<leader>tL"] = { ":set list!<CR>", "Toggle listchars" },
        ["<leader>tW"] = { ":set wrap!<CR>", "Toggle line wrap" },
        ["<leader>tc"] = { function ()
            local width = '80'
            local cc = vim.opt.colorcolumn._value
            if cc == width then
                vim.opt.colorcolumn = ''
            else
                vim.opt.colorcolumn = '80'
            end

        end, "Toggle colorcolumn" },
        ["<leader>tv"] = {
            function ()
                local virtual_text_status = vim.diagnostic.config().virtual_text
                vim.diagnostic.config({virtual_text=not virtual_text_status})
            end, "Toggle diagnostic virtual_text", opts = { noremap = "true" },
        },
        ["<leader>td"] = {
            function ()
                local signs_status = vim.diagnostic.config().signs
                vim.diagnostic.config({virtual_text=not signs_status, signs=not signs_status})
            end,
            "Toggle diagnostic signs and virtual_text", opts = { noremap = "true" },
        },
    },
}

M.file = {
    n = {
        ["<leader>cc"] = { "<Cmd>cd %:h<CR>", "cd Parent of buffer" },
        ["<leader>ck"] = { "<Cmd>cd ..<CR>", "cd One folder up" },
        ["<leader>cj"] = {
            function ()
                -- local root_dir = vim.loop.cwd()
                -- HACK: recursive b/c doesn't work on first call ¯\_(ツ)_/¯
                local function trim()
                    local buf_dir = tostring(vim.fn.expand("%"))
                    local trim_index = string.find(buf_dir, "/")
                    local one_down = string.sub(buf_dir, 0, trim_index)
                    vim.cmd("cd ./" .. one_down)
                    if (trim_index == 1) and (one_down == '/') then
                        trim()
                    end
                end
                trim()
            end,
            "cd One folder down" },

        ["<leader>cdr"] = { "<Cmd>cd ~/<CR>", "/" },
        ["<leader>cdh"] = { "<Cmd>cd ~/<CR>", "$HOME" },
        ["<leader>cdd"] = { "<Cmd>cd ~/workspace<CR>", "~/dev" },
        ["<leader>cdg"] = { "<Cmd>cd ~/workspace/cs50<CR>", "cs50" },
        ["<leader>ceb"] = { "<Cmd>e ~/.bashrc<CR>", ".bashrc" },

        ["<leader>cdna"] = { "<Cmd>cd ~/.config/AstroNvim/lua/<CR>",             "AstroNvim" },
        ["<leader>cdnc"] = { "<Cmd>cd ~/.config/NvChad/<CR>",                    "NvChad" },
        ["<leader>cdnn"] = { "<Cmd>cd ~/.config/nvim/<CR>",                      "Base neovim" },

        ["<leader>cdnl"] = { "<Cmd>cd ~/.config/LazyVim/<CR>",                   "LazyVim" },
        ["<leader>cdnL"] = { "<Cmd>cd ~/.local/share/LazyVim/lazy/LazyVim/<CR>", "LazyVim .local/share" },

        ["<leader>cena"] = { "<Cmd>e ~/.config/AstroNvim/lua/<CR>",                                 "AstroNvim" },
        ["<leader>cenc"] = { "<Cmd>e ~/.config/NvChad/lua/custom/plugins.lua<CR>",                  "NvChad" },
        ["<leader>cenn"] = { "<Cmd>e ~/.config/nvim/lua/plugins/init.lua<CR>",                      "Base neovim" },
        ["<leader>cenl"] = { "<Cmd>e ~/.config/LazyVim/lua/config/lazy.lua<CR>",                    "LazyVim" },
        ["<leader>cenL"] = { "<Cmd>e ~/.local/share/LazyVim/lazy/LazyVim/lua/lazyvim/init.lua<CR>", "LazyVim .local/share" },
    }
}

M.buffer = {
    n = {
        ["<leader>x"] = { "<Cmd> bd <Cr>", "Delete buffer", opts = opts },
        ["<leader>bn"] = { "<Cmd> tabnew <CR>", "New tab" },
        ["[[b"] = { "<Cmd> +tabmove <CR>", "Move tab left" },
        ["]]b"] = { "<Cmd> -tabmove <CR>", "Move tab right" },
        ["<S-h>"] = { "gT", "Prev tab" },
        ["<S-l>"] = { "gt", "Next tab" },
        ["[b"] = { "<Cmd> bprev <cr>", "Prev buffer", opts = opts },
        ["]b"] = { "<Cmd> bnext <cr>", "Next buffer", opts = opts },
    },
}

M.bufferline = {
    plugin = true,
    opts = opts,

    n = {
        ["<leader>bp"]  = { "<Cmd>BufferLineTogglePin<CR>",                       "Toggle pin", },
        ["<leader>bP"]  = { "<Cmd>BufferLineGroupClose ungrouped<CR>",            "Delete non-pinned buffers", },
        ["<leader>bo"]  = { "<Cmd>BufferLineCloseOthers<CR>",                     "Delete other buffers", },
        ["<leader>br"]  = { "<Cmd>BufferLineCloseRight<CR>",                      "Delete buffers to the right", },
        ["<leader>bl"]  = { "<Cmd>BufferLineCloseLeft<CR>",                       "Delete buffers to the left", },
        ["<leader>be"]  = { ":BufferLineSortByExtension<CR>",                     "sort buffers by extension ", },
        ["<leader>bd"]  = { ":BufferLineSortByDirectory<CR>",                     "sort buffers by directory", },
        ["<leader>bt"]  = { ":BufferLineSortByTabs<CR>",                          "sort buffers by tabs", },
        ["<S-h>"]       = { "<Cmd>BufferLineCyclePrev<cr>",                       "Prev buffer", },
        ["<S-l>"]       = { "<Cmd>BufferLineCycleNext<cr>",                       "Next buffer", },
        ["<leader>bgD"] = { "<Cmd>BufferLinePickClose<CR>",                       "Pick close buffer", },
        ["<leader>1"]   = { "<Cmd>lua require('bufferline').go_to(1, true)<cr>",  "buffer 1", },
        ["<leader>2"]   = { "<Cmd>lua require('bufferline').go_to(2, true)<cr>",  "buffer 2", },
        ["<leader>3"]   = { "<Cmd>lua require('bufferline').go_to(3, true)<cr>",  "buffer 3", },
        ["<leader>4"]   = { "<Cmd>lua require('bufferline').go_to(4, true)<cr>",  "buffer 4", },
        ["<leader>5"]   = { "<Cmd>lua require('bufferline').go_to(5, true)<cr>",  "buffer 5", },
        ["<leader>6"]   = { "<Cmd>lua require('bufferline').go_to(6, true)<cr>",  "buffer 6", },
        ["<leader>7"]   = { "<Cmd>lua require('bufferline').go_to(7, true)<cr>",  "buffer 7", },
        ["<leader>8"]   = { "<Cmd>lua require('bufferline').go_to(8, true)<cr>",  "buffer 8", },
        ["<leader>9"]   = { "<Cmd>lua require('bufferline').go_to(9, true)<cr>",  "buffer 9", },
        ["<leader>$"]   = { "<Cmd>lua require('bufferline').go_to(-1, true)<cr>", "buffer last", },
    },
}

M.harpoon = {
    plugin = true,

    n = {
        ["<leader>ha"] = { require("harpoon.mark").add_file, "Add file" },
        ["<leader>hu"] = { require("harpoon.ui").toggle_quick_menu, "Toggle UI" },

        ['<C-n>'] = { function() require("harpoon.ui").nav_next() end, 'Harpoon next mark' },
        ['<C-p>'] = { function() require("harpoon.ui").nav_prev() end, 'Harpoon prev mark' },

        ["<leader>h1"] = { function() require("harpoon.ui").nav_file(1) end, "nav file 1" },
        ["<leader>h2"] = { function() require("harpoon.ui").nav_file(2) end, "nav file 2" },
        ["<leader>h3"] = { function() require("harpoon.ui").nav_file(3) end, "nav file 3" },
        ["<leader>h4"] = { function() require("harpoon.ui").nav_file(4) end, "nav file 4" },
        ["<leader>h5"] = { function() require("harpoon.ui").nav_file(5) end, "nav file 5" },
        ["<leader>h6"] = { function() require("harpoon.ui").nav_file(6) end, "nav file 6" },
        ["<leader>h7"] = { function() require("harpoon.ui").nav_file(7) end, "nav file 7" },
        ["<leader>h8"] = { function() require("harpoon.ui").nav_file(8) end, "nav file 8" },
        ["<leader>h9"] = { function() require("harpoon.ui").nav_file(9) end, "nav file 9" },
    },
}

M.undotree = {
    plugin = true,

    n = {
        ["<leader>u"] = { vim.cmd.UndotreeToggle, "Toggle undotree" },
    },
}

M.comment = {
    plugin = true,

    n = {
        ["<leader>/"] = {
            function()
                require("Comment.api").toggle.linewise.current()
            end,
            "Toggle comment",
        },
    },

    v = {
        ["<leader>/"] = {
            "<ESC><Cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
            "Toggle comment",
        },
    },

}

M.todo_comments = {
    plugin = true,

    n = {
        ["]tt"] = { function() require("todo-comments").jump_next() end, "Next todo comment (any keyword)" },
        ["[tt"] = { function() require("todo-comments").jump_prev() end, "Prev todo comment (any keyword)" },

        ["]td"] = { function() require("todo-comments").jump_next({keywords = { "TODO" }}) end, "Next TODO comment" },
        ["[td"] = { function() require("todo-comments").jump_prev({keywords = { "TODO" }}) end, "Prev TODO comment" },

        ["]te"] = { function() require("todo-comments").jump_next({keywords = { "ERROR", "WARNING" }}) end, "Next ERROR/WARNING comment" },
        ["[te"] = { function() require("todo-comments").jump_prev({keywords = { "ERROR", "WARNING" }}) end, "Prev ERROR/WARNING comment" },

        ["]tn"] = { function() require("todo-comments").jump_next({keywords = { "NOTE" }}) end, "Next NOTE comment" },
        ["[tn"] = { function() require("todo-comments").jump_prev({keywords = { "NOTE" }}) end, "Prev NOTE comment" },

        ["[tc"] = { function() require("todo-comments").jump_prev({keywords = { "CITE", "CITATION" }}) end, "Prev CITE comment" },
        ["]tc"] = { function() require("todo-comments").jump_next({keywords = { "CITE", "CITATION" }}) end, "Next CITE comment" },
    },
}

M.doge = {
    plugin = true,

    n = {
        ["<Leader>dg"] = { "<Plug>(doge-generate)" },
        ["<C-f>"] = { "<Plug>(doge-comment-jump-forward)" },
        ["<C-b>"] = { "<Plug>(doge-comment-jump-backward)" },
    },
    i = {
        ["<C-f>"] = { "<Plug>(doge-comment-jump-forward)" },
        ["<C-b>"] = { "<Plug>(doge-comment-jump-backward)" },
    },
    v = {
        ["<C-f>"] = { "<Plug>(doge-comment-jump-forward)" },
        ["<C-b>"] = { "<Plug>(doge-comment-jump-backward)" },
    },
}

M.nvimtree = {
    plugin = true,

    n = {
        ["<leader>e"] = { "<Cmd> NvimTreeToggle <CR>", "Toggle nvimtree" },
    },
}

M.toggleterm = {
    plugin = true,

    n = {
        ["<C-_>"] = { "<Cmd> ToggleTerm direction=float <CR>", "Toggle floating terminal" },
        ["<A-i>"] = { "<Cmd> ToggleTerm direction=float <CR>", "Toggle floating terminal" },
        ["<A-v>"] = { "<Cmd> ToggleTerm direction=vertical size=40 <CR>", "Toggle vertical terminal" },
        ["<A-h>"] = { "<Cmd> ToggleTerm direction=horizontal <CR>", "Toggle horizontal terminal" },
    },
    t = {
        ["<A-i>"] = { "<Cmd> ToggleTerm direction=float <CR>", "Toggle floating terminal" },
        ["<A-v>"] = { "<Cmd> ToggleTerm direction=vertical <CR>", "Toggle vertical terminal" },
        ["<A-h>"] = { "<Cmd> ToggleTerm direction=horizontal <CR>", "Toggle horizontal terminal" },
        ["<esc>"] = { [[<C-\><C-n>]] },
        -- ["jk"]  = { [[<C-\><C-n>]] },
        ["<C-h>"] = { [[<C-\><C-n><C-W>h]] },
        ["<C-j>"] = { [[<C-\><C-n><C-W>j]] },
        ["<C-k>"] = { [[<C-\><C-n><C-W>k]] },
        ["<C-l>"] = { [[<C-\><C-n><C-W>l]] },
    },

}

M.telescope = {
    plugin = true,

    n = {
        -- find
        ["<leader>ft"] = { "<Cmd> Telescope <CR>", "Telescope" },
        ["<leader>ff"] = { "<Cmd> Telescope find_files <CR>", "Find files" },
        ["<leader>fa"] = { "<Cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>", "Find all" },
        ["<leader>fw"] = { "<Cmd> Telescope live_grep <CR>", "Live grep" },
        ["<leader>fb"] = { "<Cmd> Telescope buffers <CR>", "Find buffers" },
        ["<leader>fh"] = { "<Cmd> Telescope help_tags <CR>", "Help page" },
        ["<leader>fo"] = { "<Cmd> Telescope oldfiles <CR>", "Find oldfiles" },
        ["<leader>fz"] = { "<Cmd> Telescope current_buffer_fuzzy_find <CR>", "Find in current buffer" },
        ["<leader>fm"] = { "<Cmd> Telescope marks <CR>", "Telescope bookmarks" },
        -- git
        ["<leader>fc"] = { "<Cmd> Telescope git_commits <CR>", "Git commits" },
        ["<leader>fg"] = { "<Cmd> Telescope git_status <CR>", "Git status" },
    },
}


M.telescope_file_browser = {
    plugin = true,
    n = {
        ["<leader>fr"] = { "<Cmd> Telescope file_browser <CR>"}
    },
}


M.fugitive = {
    plugin = true,

    n = {
        ["<leader>gs"] = { vim.cmd.Git, "Git" }
    }
}

M.dap = {
    plugin = true,

    n = {
        -- ["<leader>db"] = { "<Cmd> DapToggleBreakpoint <CR>", "Add breakpoint at line", },
        -- ["<leader>dr"] = { "<Cmd> DapContinue <CR>", "Start or continue the debugger", },
        ["<Leader>de"] = { "<Cmd>lua require'dap'.disconnect({ terminateDebuggee = true })<CR><Cmd>lua require'dap'.close()<CR>", "DAP: Exit" },

        -- CITE: https://www.reddit.com/r/neovim/comments/silikv/debugging_in_neovim/
        ["<F4>"] = { ":lua require('dapui').toggle()<CR>",                                                                        "DAP: Toggle UI" },
        ["<F5>"] = { ":lua require('dap').toggle_breakpoint()<CR>",                                                               "DAP: Toggle breakpoint" },
        ["<F9>"] = { ":lua require('dap').continue()<CR>",                                                                        "DAP: Continue" },

        ["<F1>"] = { ":lua require('dap').step_over()<CR>",                                                                       "DAP: Step Over" },
        ["<F2>"] = { ":lua require('dap').step_into()<CR>",                                                                       "DAP: Step Into" },
        ["<F3>"] = { ":lua require('dap').step_out()<CR>",                                                                        "DAP: Step Out" },

        ["<Leader>dsc"] = { ":lua require('dap').continue()<CR>",                                                                 "DAP: Continue" },
        ["<Leader>dsv"] = { ":lua require('dap').step_over()<CR>",                                                                "DAP: Step Over" },
        ["<Leader>dsi"] = { ":lua require('dap').step_into()<CR>",                                                                "DAP: Step Into" },
        ["<Leader>dso"] = { ":lua require('dap').step_out()<CR>",                                                                 "DAP: Step Out" },

        ["<Leader>dhh"] = { ":lua require('dap.ui.variables').hover()<CR>" },

        ["<Leader>duh"] = { ":lua require('dap.ui.widgets').hover()<CR>" },
        ["<Leader>duf"] = { ":lua local widgets=require('dap.ui.widgets');widgets.centered_float(widgets.scopes)<CR>", "" },

        ["<Leader>dro"] = { ":lua require('dap').repl.open()<CR>" },
        ["<Leader>drl"] = { ":lua require('dap').repl.run_last()<CR>" },

        ["<Leader>dbc"] = { ":lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",                     "DAP: Toggle breakpoint, conditional" },
        ["<Leader>dbm"] = { ":lua require('dap').set_breakpoint( nil, nil, vim.fn.input('Log point message: '))<CR>",             "DAP: Toggle breakpoint, message" },
        ["<Leader>dbt"] = { ":lua require('dap').toggle_breakpoint()<CR>",                                                        "DAP: Toggle breakpoint" },

        ["<Leader>dc"] = { ":lua require('dap.ui.variables').scopes()<CR>" },
        ["<Leader>di"] = { ":lua require('dapui').toggle()<CR>",                                                                  "DAP: Toggle UI" },
    },

    v = {
        ["<Leader>dhv"] = { ":lua require('dap.ui.variables').visual_hover()<CR>" },
        -- ENDCITE:
    },
}

M.dap_python = {
    plugin = true,

    n = {
        ["<Leader>dpr"] = { function () require('dap-python').test_method() end, "DAP: python test_method" }
    }
}

M.cellular_automaton = {
    plugin = true,

    n = {
        ["<leader>ar"] = { "<Cmd>CellularAutomaton make_it_rain<CR>", "Make it rain!" },
        ["<leader>ag"] = { "<Cmd>CellularAutomaton game_of_life<CR>", "Game of life" },
    }
}


M.dadbod_iu = {
    plugin = true,

    n = {
        ["<leader>lu"] = { "<Cmd> DBUI <CR>" },
        ["<leader>lt"] = { "<Cmd> DBUIToggle <CR>" },
        ["<leader>la"] = { "<Cmd> DBUIAddConnection <CR>" },
        ["<leader>lb"] = { "<Cmd> DBUIFindBuffer <CR>" },
    },
}

M.zen_mode = {
    plugin = true,

    n = {
        ["<leader>z"] = { "<Cmd> ZenMode <CR>", "Toggle ZenMode" },

    }

}

        -- cmd = {"MacroSave", "MacroYank", "MacroSelect", "MacroDelete"},
M.macros = {
    plugin = true,

    n = {
        ["<leader>qw"] = { "<Cmd> MacroSave <CR>", "Save macro" },
        ["<leader>qy"] = { "<Cmd> MacroYank <CR>", "Yank macro" },
        ["<leader>qs"] = { "<Cmd> MacroSelect <CR>", "Select macro" },
        ["<leader>qd"] = { "<Cmd> MacroDelete <CR>", "Delete macro" },
    }
}

-- NOTE: boilerplate

M.name = {
    plugin = true,
    n = {
    },

    v = {
        ["<leader>f"] = { "<Cmd> f <CR>" },
        ["<leader>f"] = { "<Cmd> f <CR>", "f" },
        ["<leader>f"] = { "<Cmd> f <CR>", opts = opts },
        ["<leader>f"] = { "<Cmd> f <CR>", "f", opts = opts },

        ["<leader>f"] = { "f" },
        ["<leader>f"] = { "f", 'f' },
        ['<leader>f'] = { 'f', opts = opts },
        ["<leader>f"] = { "f", "f", opts = opts },

        ["<leader>f"] = { function () return false end, },
        ["<leader>f"] = { function () return false end, "" },
        ["<leader>f"] = { function () return false end, opts = opts },
        ["<leader>f"] = { function () return false end, "", opts = opts },
    },
}

return M

