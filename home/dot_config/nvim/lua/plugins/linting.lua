-- Python linting and formatting plugins
return {
    -- On-demand linting with nvim-lint
    {
        "mfussenegger/nvim-lint",
        event = "VeryLazy",
        config = function()
            local lint = require("lint")
            
            -- Configure linters
            lint.linters_by_ft = {
                python = { "ruff", "mypy" },
            }
            
            -- Ruff configuration (replaces flake8, isort, and more)
            lint.linters.ruff.args = {
                "check",
                "--output-format=text",
                "--stdin-filename", function() return vim.api.nvim_buf_get_name(0) end,
                "--line-length=119",
                "--exclude=*.ipynb",
                "-"
            }
            
            -- Mypy for advanced type checking
            lint.linters.mypy.args = {
                "--show-column-numbers",
                "--show-error-codes", 
                "--no-error-summary",
                "--ignore-missing-imports",
            }
            
            -- Manual linting functions
            local function lint_file()
                if vim.bo.filetype == "python" then
                    lint.try_lint()
                    vim.notify("Python linting complete (ruff + mypy)", vim.log.levels.INFO)
                else
                    vim.notify("Not a Python file", vim.log.levels.WARN)
                end
            end
            
            local function lint_ruff_only()
                if vim.bo.filetype == "python" then
                    lint.try_lint("ruff")
                    vim.notify("Ruff linting complete", vim.log.levels.INFO)
                else
                    vim.notify("Not a Python file", vim.log.levels.WARN)
                end
            end
            
            local function lint_mypy_only()
                if vim.bo.filetype == "python" then
                    lint.try_lint("mypy")
                    vim.notify("Mypy type checking complete", vim.log.levels.INFO)
                else
                    vim.notify("Not a Python file", vim.log.levels.WARN)
                end
            end
            
            -- Keybindings (using <leader>d for diagnostics/linting)
            vim.keymap.set('n', '<leader>dl', lint_file, { desc = 'Lint: Run all Python linters' })
            vim.keymap.set('n', '<leader>dr', lint_ruff_only, { desc = 'Lint: Ruff only' })
            vim.keymap.set('n', '<leader>dt', lint_mypy_only, { desc = 'Lint: Mypy type check' })
        end,
    },
    
    -- Code formatting with conform.nvim
    {
        "stevearc/conform.nvim",
        event = "BufWritePre",
        cmd = "ConformInfo",
        keys = {
            {
                "<leader>df",
                function()
                    require("conform").format({ async = true, lsp_format = "fallback" })
                end,
                mode = { "n", "v" },
                desc = "Format: Format buffer",
            },
        },
        config = function()
            require("conform").setup({
                formatters_by_ft = {
                    python = { "ruff_format", "ruff_organize_imports" },
                    lua = { "stylua" },
                    javascript = { { "prettierd", "prettier" } },
                    typescript = { { "prettierd", "prettier" } },
                },
                
                -- Ruff formatting configuration
                formatters = {
                    ruff_format = {
                        args = {
                            "format",
                            "--line-length=119",
                            "--stdin-filename", "$FILENAME",
                            "-"
                        },
                    },
                    ruff_organize_imports = {
                        args = {
                            "check",
                            "--select", "I",
                            "--fix",
                            "--stdin-filename", "$FILENAME", 
                            "-"
                        },
                    },
                },
                
                -- Format on save (optional - can be disabled)
                format_on_save = function(bufnr)
                    -- Disable format on save for specific filetypes
                    local disable_filetypes = { c = true, cpp = true }
                    if disable_filetypes[vim.bo[bufnr].filetype] then
                        return
                    end
                    
                    -- Only format Python files on save if you want auto-formatting
                    -- Comment this out if you prefer manual formatting only
                    if vim.bo[bufnr].filetype == "python" then
                        return { timeout_ms = 500, lsp_format = "fallback" }
                    end
                end,
            })
            
            -- Additional keybindings
            vim.keymap.set('n', '<leader>dF', function()
                require("conform").format({ 
                    formatters = { "ruff_format", "ruff_organize_imports" },
                    async = true 
                })
                vim.notify("Python formatting complete", vim.log.levels.INFO)
            end, { desc = 'Format: Python (ruff format + imports)' })
        end,
    },
}
