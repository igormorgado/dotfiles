-- Fuzzy finding plugins
return {
    {
        'nvim-telescope/telescope.nvim', 
        cmd = "Telescope",
        dependencies = { 'nvim-lua/plenary.nvim' }, 
        keys = {
            { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find: Files" },
            { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Find: Live grep" },
            { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find: Buffers" },
            { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Find: Help tags" },
        },
        config = function()
            require('telescope').setup({
                defaults = {
                    file_ignore_patterns = { "node_modules", ".git/", "*.pyc", "__pycache__/", "*.o", "*.a", "*.so" },
                    layout_strategy = "horizontal",
                    layout_config = { 
                        width = 0.95, 
                        height = 0.85,
                        horizontal = {
                            prompt_position = "top",
                            preview_width = 0.55,
                        }
                    },
                    sorting_strategy = "ascending",
                    prompt_prefix = " ",
                    selection_caret = " ",
                    path_display = { "truncate" },
                }
            })
        end
    },
}
