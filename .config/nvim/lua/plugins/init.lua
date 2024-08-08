
require("lazy").setup({

    -- local plugins

    {
        "restore_view.vim",
        dev = true,
    },

    -- save macros
    {
        "kr40/nvim-macros",
        cmd = {"MacroSave", "MacroYank", "MacroSelect", "MacroDelete"},
        init = function ()
            require("core.utils").load_mappings "macros"
        end,
        opts = {
            json_file_path = vim.fs.normalize(vim.fn.stdpath("config") .. "/macros.json"), -- Location where the macros will be stored
            default_macro_register = "q", -- Use as default register for :MacroYank and :MacroSave and :MacroSelect Raw functions
            json_formatter = "jq", -- can be "none" | "jq" | "yq" used to pretty print the json file (jq or yq must be installed!)
        },
    },

    -- lua documentation
    {
        "milisims/nvim-luaref",
        event = "VeryLazy",
    },

    -- utils dependency
    {
        "nvim-lua/plenary.nvim",
    },

    -- UI Stuff

    -- colorscheme
    {
        "navarasu/onedark.nvim",
        init = function()
            require("onedark").load()
        end,
        opts = {
            style = 'darker',
            code_style = {
                comments = 'italic',
                keywords = 'none',
                functions = 'none',
                strings = 'none',
                variables = 'none'
            },
        },
    },

    -- statusline
    {
        "nvim-lualine/lualine.nvim",
        -- dependencies = {"wordcount"},
        opts = function ()
            return require("plugins.configs.lualine")
        end,
    },

    -- syntax highlighting
    {
        "nvim-treesitter/nvim-treesitter",
        opts = function()
            return require("plugins.configs.treesitter")
        end,
    },

    -- tabs
    {
        "akinsho/bufferline.nvim",
        dependencies = "nvim-tree/nvim-web-devicons",
        event = "VeryLazy",
        init = function ()
            require("core.utils").load_mappings "bufferline"
        end,
        opts = function ()
            return require("plugins.configs.bufferline")
        end
    },

    -- toggleterm
    {
        "akinsho/toggleterm.nvim",
        version = "*",
        cmd = "ToggleTerm",
        build = ":ToggleTerm",
        keys = {
            { "<C-/", "<cmd>ToggleTerm<CR>", desc = "Toggle horizontal terminal" },
        },
        init = function ()
            require("core.utils").load_mappings "toggleterm"
        end,
        opts = {
            require("plugins.configs.toggleterm")
        },
    },

    -- comments
    {
        "numToStr/Comment.nvim",
        init = function()
            require("core.utils").load_mappings "comment"
        end,
        lazy = false,
    },

    -- code folds
    {
        "kevinhwang91/nvim-ufo",
        dependencies = "kevinhwang91/promise-async",
        opts = function()
            return require("plugins.configs.ufo")
        end,
    },

    -- TODO: comments
    {
        "folke/todo-comments.nvim",
        init = function()
            require("core.utils").load_mappings "todo_comments"
        end,
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = function ()
            return require("plugins.configs.todo")
        end,
    },

    -- documentation generator
    {
        "kkoomen/vim-doge",
        keys = { "<leader>dg", "<Plug>(doge-generate)" },
        init = function ()
            vim.cmd([[let g:doge_enable_mappings = 0]])
            require("core.utils").load_mappings "doge"
        end,
    },

    -- autopairs
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        opts = {},
    },

    -- marks
    {
        "chentoast/marks.nvim",
        opts = function ()
            return require("plugins.configs.marks")
        end,
    },

    {
        "theprimeagen/harpoon",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        init = function ()
            require("core.utils").load_mappings "harpoon"
        end
    },

    {
        "mbbill/undotree",
        init = function ()
            require("core.utils").load_mappings "undotree"
        end
    },

    -- file manager
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = {
            {"nvim-tree/nvim-web-devicons"},
        },
        cmd = { "NvimTreeToggle", "NvimTreeFocus" },
        init = function()
            require("core.utils").load_mappings "nvimtree"
        end,
        opts = function()
            return require "plugins.configs.nvimtree"
        end,
        config = function(_, opts)
            require("nvim-tree").setup(opts)
        end,
    },

    -- fuzzy finder
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter", { "nvim-telescope/telescope-fzf-native.nvim", build = "make" } },
        cmd = "Telescope",
        init = function()
            require("core.utils").load_mappings "telescope"
        end,
        opts = function()
            return require "plugins.configs.telescope"
        end,
        config = function(_, opts)
            require("telescope").setup(opts)
        end,
    },

    {
        "nvim-telescope/telescope-file-browser.nvim",
        dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
        init = function ()
            require("core.utils").load_mappings "telescope_file_browser"
        end,
        config = function (_, _)
            require("telescope").load_extension "file_browser"
        end,
    },

    -- mason
    {
        "williamboman/mason.nvim",
        cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUpdate" },
        opts = function()
            return require "plugins.configs.mason"
        end,
        config = function(_, opts)
            require("mason").setup(opts)
            -- custom nvchad cmd to install all mason binaries listed
            vim.api.nvim_create_user_command("MasonInstallAll", function()
                vim.cmd("MasonInstall " .. table.concat(opts.ensure_installed, " "))
            end, {})
        end,
    },

    {
        "williamboman/mason-lspconfig.nvim",
    },

    -- git
    {
        "tpope/vim-fugitive",
        init = function ()
            require("core.utils").load_mappings "fugitive"
        end
    },

    {
        "lewis6991/gitsigns.nvim",
    },

    -- lsp-zero (lsp & cmp)
    {
        "VonHeikemen/lsp-zero.nvim",
        event = "VeryLazy",
        branch = "v3.x",
        lazy = true,
        dependencies = {
            { "neovim/nvim-lspconfig", },
            { "williamboman/mason.nvim", },
            { "williamboman/mason-lspconfig.nvim" },
            { "hrsh7th/cmp-nvim-lsp", },
            { "hrsh7th/nvim-cmp", },
            { "L3MON4D3/LuaSnip", },
            { "saadparwaiz1/cmp_luasnip" },
            { "rafamadriz/friendly-snippets", },
        },
        config = function (_, _)
            require("plugins.configs.lsp")
        end
    },

    -- debugging
    {
        "mfussenegger/nvim-dap-python",
        ft = "python",
        dependencies = {
            "mfussenegger/nvim-dap",
            "rcarriga/nvim-dap-ui",
        },
        config = function (_, opts)
            local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
            require("dap-python").setup(path)
            require("core.utils").load_mappings "dap_python"
        end,
    },

    -- {
    --     "microsoft/debugpy"
    -- },

    {
        "rcarriga/nvim-dap-ui",
        event = "VeryLazy",
        dependencies = "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio",
        config = function()
            require('plugins.configs.dap')
        end
    },

    -- mason-dap linker
    {
        "jay-babu/mason-nvim-dap.nvim",
        event = "VeryLazy",
        dependencies = {
            "williamboman/mason.nvim",
            "mfussenegger/nvim-dap",
        },
        opts = {
            handlers = {},
            ensure_installed = {
                "codelldb",
            }
        }
    },
    {
        "mfussenegger/nvim-dap",
        config = function(_, _)
            require("core.utils").load_mappings "dap"
        end
    },

    -- SQL Database stuff
    {
        "kristijanhusak/vim-dadbod-ui",
        dependencies = {
            { "tpope/vim-dadbod", lazy = true },
            { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
        },
        cmd = {
            "DBUI",
            "DBUIToggle",
            "DBUIAddConnection",
            "DBUIFindBuffer",
        },
        init = function()
            -- Your DBUI configuration
            vim.g.db_ui_use_nerd_fonts = 1
            require("core.utils").load_mappings "dadbod_iu"
        end,
    },

    -- ZenMode
    {
        "folke/zen-mode.nvim",
        event = "VeryLazy",
        init = function ()
            require("core.utils").load_mappings "zen_mode"
        end
    },

    -- tmux-navigator
    {
        "christoomey/vim-tmux-navigator",
        cmd = {
            "TmuxNavigateLeft",
            "TmuxNavigateDown",
            "TmuxNavigateUp",
            "TmuxNavigateRight",
            "TmuxNavigatePrevious",
        },
        keys = {
            { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
            { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
            { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
            { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
            { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
        },
    },

    {
        "kawre/leetcode.nvim",
        build = ":TSUpdate html",
        dependencies = {
            "nvim-telescope/telescope.nvim",
            "nvim-lua/plenary.nvim", -- required by telescope
            "MunifTanjim/nui.nvim",

            -- optional
            "nvim-treesitter/nvim-treesitter",
            -- "rcarriga/nvim-notify",
            "nvim-tree/nvim-web-devicons",
        },
        cmd = "Leet",
        opts = {
            -- non_standalone = true,
        },
    },

    {
        "eandrju/cellular-automaton.nvim",
        cmd = {
            "CellularAutomaton",
        },
        init = function ()
            require("core.utils").load_mappings "cellular_automaton"
        end
    },

    -- which-key
    {
        "folke/which-key.nvim",
        dependencies = "nvim-tree/nvim-web-devicons",
        event = "VeryLazy",
        init = function()
            require("plugins.configs.which-key").init()
        end,
        config = function (_, _)
            require("plugins.configs.which-key").config()
        end,
    },

},
{ -- opts
    dev = {
        path = "~/.config/nvim/local_plugins"
    }
})
