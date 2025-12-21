-- Treesitter for syntax highlighting and code navigation
return {
    {
        "nvim-treesitter/nvim-treesitter",
        dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
        event = { "BufReadPost", "BufNewFile" },
        build = ":TSUpdate",
        config = function()
            local treesitter_parser_install_dir = vim.fn.stdpath("data") .. "/treesitter"
            require("nvim-treesitter.configs").setup({
                parser_install_dir = treesitter_parser_install_dir,
                ensure_installed = {
                    "python", "c", "vim", "javascript", "sql", "vimdoc",
                    "html", "query", "css", "lua", "markdown", "markdown_inline", "json",
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
                textobjects = {
                    select = {
                        enable = true,
                        lookahead = true,
                        keymaps = {
                            ["af"] = "@function.outer",
                            ["if"] = "@function.inner",
                            ["ac"] = "@class.outer",
                            ["ic"] = "@class.inner",
                        },
                    },
                },
            })
            vim.opt.runtimepath:append(treesitter_parser_install_dir)
            vim.keymap.set('n', '<leader>vs', function()
                require('nvim-treesitter.incremental_selection').init_selection()
                require('nvim-treesitter.incremental_selection').scope_incremental()
            end, { desc = "Select entire scope" })

            vim.keymap.set('n', '<F12>', function()
                if vim.fn.exists(':Inspect') == 2 then
                    vim.cmd('Inspect')
                else
                    vim.notify("Inspect command not available (requires newer Neovim)", vim.log.levels.WARN)
                end
            end, { desc = "Inspect highlights/TreeSitter at cursor" })

            -- TreeSitter folds: set globally (not just current window)
            vim.opt.foldmethod = "expr"
            vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
            vim.opt.foldlevel = 99
        end
    },

    {
        "nvim-treesitter/nvim-treesitter-context", 
        opts = { enable = true, max_lines = 3 } 
    },
}
