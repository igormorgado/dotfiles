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
                    position = "float",
                    float = {
                        width = 95,
                        height = "90%",
                        row = "5%",
                        col = "70%",
                        relative = "editor",
                        border = "rounded"
                    },
                    enter_insert = true,
                    hide_numbers = true,
                    hide_signcolumn = true,
                    hide_cursorcolumn = true,
                    hide_colorcolumn = true,
                    wrap = true,
                },
                refresh = {
                    enable = true,
                    updatetime = 200,
                    timer_interval = 200,
                    show_notifications = false,
                },
                git = {
                    use_git_root = true,
                    auto_stage = false,
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
                    code = "--code",
                },
                keymaps = {
                    toggle = {
                        normal = "<C-,>",
                        terminal = "<C-,>",
                        variants = {
                            continue = "<leader>cC",
                            verbose = "<leader>cV",
                            resume = "<leader>cR",
                        },
                    },
                    window_navigation = true,
                    scrolling = true,
                    send_selection = "<leader>cs",
                }
            })
            -- Enhanced keybindings
            vim.keymap.set('n', '<leader>cc', '<cmd>ClaudeCode<CR>', { desc = 'Code: Toggle Claude Code' })
            vim.keymap.set('n', '<leader>cn', '<cmd>ClaudeCode new<CR>', { desc = 'Code: New Claude conversation' })
            vim.keymap.set('v', '<leader>cs', function()
                local start_pos = vim.fn.getpos("'<")
                local end_pos = vim.fn.getpos("'>")
                local lines = vim.fn.getline(start_pos[2], end_pos[2])
                -- Send selected text to Claude
                vim.cmd('ClaudeCode')
                -- You can add logic here to send the selection
            end, { desc = 'Code: Send selection to Claude' })
            vim.keymap.set('n', '<leader>cq', '<cmd>ClaudeCode --quit<CR>', { desc = 'Code: Quit Claude session' })
            vim.keymap.set('n', '<leader>ch', '<cmd>ClaudeCode --help<CR>', { desc = 'Code: Claude help' })
        end
    },
}
