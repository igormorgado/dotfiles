-- AI and code assistance plugins
return {
    {
        "greggh/claude-code.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim"
        },
        config = function()
            require("claude-code").setup({
                window = {
                    split_ratio = 0.3,
                    position = "botleft",
                    enter_insert = true,
                    hide_numbers = true,
                    hide_signcolumn = true,
                },
                refresh = {
                    enable = true,
                    updatetime = 100,
                    timer_interval = 100,
                    show_notifications = true,
                },
                git = {
                    use_git_root = true,
                },
                shell = {
                    separator = '&&',
                    pushd_cmd = 'pushd',
                    popd_cmd = 'popd',
                },
                command = "claude",
                command_variants = {
                    continue = "--continue",
                    resume = "--resume",
                    verbose = "--verbose",
                },
                keymaps = {
                    toggle = {
                        normal = "<C-,>",
                        terminal = "<C-,>",
                        variants = {
                            continue = "<leader>cC",
                            verbose = "<leader>cV",
                        },
                    },
                    window_navigation = true,
                    scrolling = true,
                }
            })
            vim.keymap.set('n', '<leader>cc', '<cmd>ClaudeCode<CR>', { desc = 'Toggle Claude Code' })
        end
    },
}
