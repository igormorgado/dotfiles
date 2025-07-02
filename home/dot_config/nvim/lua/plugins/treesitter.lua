-- Treesitter for syntax highlighting and code navigation
return {
    {
        "nvim-treesitter/nvim-treesitter", 
        event = { "BufReadPost", "BufNewFile" }, 
        build = ":TSUpdate", 
        config = function()
            local treesitter_parser_install_dir = vim.fn.stdpath("data") .. "/treesitter"
            require("nvim-treesitter.configs").setup({
                parser_install_dir = treesitter_parser_install_dir,
                ensure_installed = {
                    "python", "c", "vim", "javascript", "sql", "vimdoc",
                    "html", "query", "css", "lua", "markdown", "markdown_inline", 
                },
                auto_install = true,
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = "gnn",
                        node_incremental = "grn",
                        scope_incremental = "grc",
                        node_decremental = "grm",
                    },
                },
                indent = {
                    enable = true
                },
                fold = {
                    enable = true
                },
            })
            vim.opt.runtimepath:append(treesitter_parser_install_dir)
            vim.keymap.set('n', '<leader>vs', function()
                require('nvim-treesitter.incremental_selection').init_selection()
                require('nvim-treesitter.incremental_selection').scope_incremental()
            end, { desc = "Select entire scope" })
            vim.wo.foldmethod = "expr"
            vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
        end
    },

    {
        "nvim-treesitter/nvim-treesitter-context", 
        opts = { enable = true, max_lines = 3 } 
    },
}