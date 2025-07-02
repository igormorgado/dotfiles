-- Fuzzy finding plugins
return {
    {
        'nvim-telescope/telescope.nvim', 
        cmd = "Telescope",
        dependencies = { 'nvim-lua/plenary.nvim' }, 
        keys = {
            { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Telescope find files" },
            { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Telescope live grep" },
            { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Telescope buffers" },
            { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Telescope help tags" },
            { "<leader>b", "<cmd>Telescope buffers<cr>", desc = "Telescope buffers" },
            { "<leader>tf", "<cmd>Telescope find_files<cr>", desc = "Telescope find files" },
        },
        config = function()
            require('telescope').setup({})
        end
    },
}