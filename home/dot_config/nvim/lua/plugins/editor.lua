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
                delay = 500,  -- Increased delay to prevent overlapping keymap warnings
                -- Configure icons to use mini.icons
                icons = {
                    breadcrumb = "»",
                    separator = "➜",
                    group = "+",
                    ellipsis = "…",
                    mappings = false,  -- Disable which-key's internal mappings icons since we have mini.icons
                },
                -- Disable certain triggers that cause conflicts
                -- Exclude terminal mode ('t') from which-key triggers
                triggers = {
                    { "<auto>", mode = "nxso" },  -- Removed 't' (terminal) mode
                },
                spec = {
                    -- nvim-surround keymaps (explicit definitions to prevent overlap warnings)
                    { "ys", desc = "Add surround" },
                    { "yss", desc = "Add surround to line" },
                    { "yS", desc = "Add surround (new lines)" },
                    { "ySS", desc = "Add surround to line (new lines)" },
                    { "ds", desc = "Delete surround" },
                    { "cs", desc = "Change surround" },
                    { "cS", desc = "Change surround (new lines)" },
                    
                    -- Comment.nvim keymaps (explicit definitions)
                    { "gc", desc = "Comment toggle linewise" },
                    { "gcc", desc = "Comment toggle current line" },
                    { "gb", desc = "Comment toggle blockwise" },
                    { "gbc", desc = "Comment toggle current block" },
                    { "gcO", desc = "Comment insert above" },
                    { "gco", desc = "Comment insert below" },
                    { "gcA", desc = "Comment insert end of line" },
                    
                    -- General groups
                    { "g", group = "goto" },
                    { "]", group = "next" },
                    { "[", group = "prev" },
                    { "<leader>b", group = "Buffer" },
                    { "<leader>c", group = "Code" },
                    { "<leader>d", group = "Diagnostics/Lint" },
                    { "<leader>e", group = "Execute/REPL" },
                    { "<leader>f", group = "Find" },
                    { "<leader>g", group = "Git" },
                    { "<leader>h", group = "Git Hunk" },
                    { "<leader>l", group = "Language" },
                    { "<leader>t", group = "Toggle" },
                    { "<leader>x", group = "Diagnostics" },
                }
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