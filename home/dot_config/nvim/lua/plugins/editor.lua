-- Editor enhancement plugins
return {
    {
        "nvim-tree/nvim-tree.lua",
        cmd = { "NvimTreeToggle", "NvimTreeFocus", "NvimTreeOpen" },
        keys = {
            { "-", "<cmd>NvimTreeFocus<cr>", desc = "Open file browser" },
        },
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("nvim-tree").setup({
                sort = { sorter = "case_sensitive" },
                view = { width = 40 },
                renderer = { group_empty = true },
                filters = { dotfiles = true },
            })
        end
    },

    {
        "folke/trouble.nvim", 
        opts = {}, 
        cmd = "Trouble", 
        keys = {
            { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics: Toggle" },
            { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Diagnostics: Buffer only" },
            { "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Code: Symbols" },
            { "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "Code: LSP definitions/references" },
            { "<leader>xl", "<cmd>Trouble loclist toggle<cr>", desc = "Diagnostics: Location list" },
            { "<leader>xq", "<cmd>Trouble qflist toggle<cr>", desc = "Diagnostics: Quickfix list" },
        },
    },

    {
        "mbbill/undotree", 
        cmd = "UndotreeToggle", 
        keys = { 
            { "<leader>u", "<cmd>UndotreeToggle<CR>", desc = "Toggle Undo Tree" } 
        } 
    },

    {
        'tpope/vim-unimpaired', 
        event = "VeryLazy" 
    },

    {
        'kshenoy/vim-signature', 
        event = "VeryLazy" 
    },

    {
        'konfekt/vim-DetectSpellLang',
        event = "VeryLazy",
        init = function()
            vim.g.detectspelllang_langs = { 
                aspell = { 'en_US', 'en', 'pt_BR', 'es', 'fr_FR', 'fr' }, 
                hunspell =  { 'en_US', 'pt_BR', 'es_ES', 'es_MX', 'fr_FR' }, 
            }
        end,
    },

    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {},
        config = function()
            local wk = require("which-key")
            wk.setup({
                preset = "modern",
                delay = 300,
            })
            -- Register key groups
            wk.add({
                { "<leader>b", group = "Buffer" },
                { "<leader>c", group = "Code" },
                { "<leader>e", group = "Execute/REPL" },
                { "<leader>f", group = "Find" },
                { "<leader>g", group = "Git" },
                { "<leader>h", group = "Git Hunk" },
                { "<leader>l", group = "Language" },
                { "<leader>t", group = "Toggle" },
                { "<leader>x", group = "Diagnostics" },
            })
        end
    },

    {
        "kylechui/nvim-surround",
        version = "*",
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({})
        end
    },

    {
        "numToStr/Comment.nvim",
        event = "VeryLazy",
        config = function()
            require('Comment').setup({
                padding = true,
                sticky = true,
                ignore = nil,
                toggler = {
                    line = 'gcc',
                    block = 'gbc',
                },
                opleader = {
                    line = 'gc',
                    block = 'gb',
                },
                extra = {
                    above = 'gcO',
                    below = 'gco',
                    eol = 'gcA',
                },
                mappings = {
                    basic = true,
                    extra = true,
                },
                pre_hook = nil,
                post_hook = nil,
            })
        end
    },
}