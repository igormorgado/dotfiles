-- Fuzzy finding plugins
return {
    {
        'nvim-telescope/telescope.nvim', 
        cmd = "Telescope",
        dependencies = { 'nvim-lua/plenary.nvim' }, 
        keys = {
            { "<leader>f", "<cmd>Telescope find_files<cr>", desc = "Telescope find files" },
            { "<leader>g", "<cmd>Telescope live_grep<cr>", desc = "Telescope live grep" },
            { "<leader>b", "<cmd>Telescope buffers<cr>", desc = "Telescope buffers" },
            { "<leader>h", "<cmd>Telescope help_tags<cr>", desc = "Telescope help tags" },
        },
        config = function()
            require('telescope').setup({})
        end
    },
}
