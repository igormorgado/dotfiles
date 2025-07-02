-- Language-specific plugins
return {
    -- Python
    {
        "geg2102/nvim-python-repl",
        dependencies = "nvim-treesitter",
        ft = { "python" }, 
        config = function()
            require("nvim-python-repl").setup({ 
                execute_on_send = true, 
                vsplit = false, 
            })
            local repl_mappings = {
                ['<leader>eb'] = { "send_buffer_to_repl", "Send entire buffer to REPL" },
                ['<leader>ee'] = { "send_statement_definition", "Send semantic unit to REPL" },
                ['<leader>E']  = { "send_visual_to_repl", "Send visual selection to REPL" },
                ['<leader>ct'] = { "toggle_execute", "Automatically execute command in REPL after sent" },
                ['<leader>lv'] = { "toggle_vertical", "Create REPL in vertical or horizontal split" },
                ['<leader>ls'] = { "open_repl", "Opens the REPL in a window split" }
            }
            for key, command in pairs(repl_mappings) do
                vim.keymap.set("n", key, function() 
                    require("nvim-python-repl")[command[1]]() 
                end, { desc = command[2] })
            end
        end
    },

    -- LaTeX
    {
        'lervag/vimtex',
        ft = { 'tex', 'latex' },
        init = function()
            vim.g.vimtex_compiler_method = 'latexmk'
            vim.g.vimtex_view_method = 'zathura'
            vim.keymap.set('n', '<localleader>v', '<plug>(vimtex-view)', { desc='View PDF' })
            vim.keymap.set('n', '<localleader>lt', '<cmd>VimtexTocToggle<cr>', { desc='Toggle VimTeX ToC' })
        end,
    },

    -- Markdown
    {
        'preservim/vim-markdown', 
        dependencies = { 'godlygeek/tabular' }, 
        ft = 'markdown' 
    },
}