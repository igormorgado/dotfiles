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
            { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
            { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
            { "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols (Trouble)" },
            { "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "LSP Definitions / references / ... (Trouble)" },
            { "<leader>xl", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
            { "<leader>xq", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
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
}