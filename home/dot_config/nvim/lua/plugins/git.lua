-- Git integration plugins
return {
    {
        "lewis6991/gitsigns.nvim", 
        event = { "BufReadPre", "BufNewFile" },
        keys = {
            -- Navigation
            { "]c", function() require("gitsigns").next_hunk() end, desc = "Git: Next hunk" },
            { "[c", function() require("gitsigns").prev_hunk() end, desc = "Git: Previous hunk" },
            
            -- Actions
            { "<leader>hs", function() require("gitsigns").stage_hunk() end, desc = "Git: Stage hunk" },
            { "<leader>hr", function() require("gitsigns").reset_hunk() end, desc = "Git: Reset hunk" },
            { "<leader>hS", function() require("gitsigns").stage_buffer() end, desc = "Git: Stage buffer" },
            { "<leader>hu", function() require("gitsigns").undo_stage_hunk() end, desc = "Git: Undo stage hunk" },
            { "<leader>hR", function() require("gitsigns").reset_buffer() end, desc = "Git: Reset buffer" },
            { "<leader>hp", function() require("gitsigns").preview_hunk() end, desc = "Git: Preview hunk" },
            { "<leader>hb", function() require("gitsigns").blame_line({ full = true }) end, desc = "Git: Blame line" },
            { "<leader>tb", function() require("gitsigns").toggle_current_line_blame() end, desc = "Git: Toggle blame" },
            { "<leader>hd", function() require("gitsigns").diffthis() end, desc = "Git: Diff this" },
            { "<leader>hD", function() require("gitsigns").diffthis("~") end, desc = "Git: Diff this ~" },
            { "<leader>td", function() require("gitsigns").toggle_deleted() end, desc = "Git: Toggle deleted" },
            
            -- Visual mode mappings
            { "<leader>hs", function() require("gitsigns").stage_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end, mode = 'v', desc = "Git: Stage hunk" },
            { "<leader>hr", function() require("gitsigns").reset_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end, mode = 'v', desc = "Git: Reset hunk" },
            
            -- Text objects
            { "ih", function() require("gitsigns").select_hunk() end, mode = { 'o', 'x' }, desc = "Git: Select hunk" },
        },
        config = function()
            require('gitsigns').setup({
                signs = {
                    add          = { text = '┃' },
                    change       = { text = '┃' },
                    delete       = { text = '_' },
                    topdelete    = { text = '‾' },
                    changedelete = { text = '~' },
                    untracked    = { text = '┆' },
                },
                signcolumn = true,
                numhl      = false,
                linehl     = false,
                word_diff  = false,
                watch_gitdir = {
                    follow_files = true
                },
                auto_attach = true,
                attach_to_untracked = false,
                current_line_blame = false,
                current_line_blame_opts = {
                    virt_text = true,
                    virt_text_pos = 'eol',
                    delay = 1000,
                    ignore_whitespace = false,
                    virt_text_priority = 100,
                },
                current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
                sign_priority = 6,
                update_debounce = 100,
                status_formatter = nil,
                max_file_length = 40000,
                preview_config = {
                    border = 'single',
                    style = 'minimal',
                    relative = 'cursor',
                    row = 0,
                    col = 1
                },
            })
        end
    },

    { 
        "tpope/vim-fugitive", 
        event = "VeryLazy",
        keys = {
            { "<leader>gs", "<cmd>Git<cr>", desc = "Git: Status" },
            { "<leader>gd", "<cmd>Gdiff<cr>", desc = "Git: Diff" },
            { "<leader>gb", "<cmd>Git blame<cr>", desc = "Git: Blame" },
            { "<leader>gl", "<cmd>Git log<cr>", desc = "Git: Log" },
            { "<leader>gp", "<cmd>Git push<cr>", desc = "Git: Push" },
            { "<leader>gP", "<cmd>Git pull<cr>", desc = "Git: Pull" },
            { "<leader>gc", "<cmd>Git commit<cr>", desc = "Git: Commit" },
            { "<leader>ga", "<cmd>Git add .<cr>", desc = "Git: Add all" },
            
            -- Conflict resolution
            { "<leader>gh", "<cmd>diffget //2<cr>", desc = "Git: Get hunk from left (HEAD)" },
            { "<leader>gj", "<cmd>diffget //3<cr>", desc = "Git: Get hunk from right (merge)" },
            { "<leader>gk", "<cmd>Gdiffsplit!<cr>", desc = "Git: 3-way diff" },
        }
    },

    {
        "NeogitOrg/neogit",
        cmd = "Neogit",
        keys = {
            { "<leader>gn", "<cmd>Neogit<cr>", desc = "Git: Open Neogit" },
        },
        dependencies = {
            "nvim-lua/plenary.nvim",
            "sindrets/diffview.nvim",
            "nvim-telescope/telescope.nvim",
        },
        config = function()
            require("neogit").setup({
                graph_style = "unicode",
            })
        end
    },
}