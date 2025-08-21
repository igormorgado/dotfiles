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
                        width = "45%",      -- Take up 45% of screen width
                        height = "90%",     -- Take up 90% of screen height
                        row = "5%",         -- Small margin from top
                        col = "52%",        -- Position on right side
                        relative = "editor",
                        border = "rounded"  -- Rounded border for aesthetics
                    },
                    enter_insert = true,
                    hide_numbers = true,
                    hide_signcolumn = true,
                    wrap = true,         -- Enable text wrapping for better readability
                },
                refresh = {
                    enable = true,
                    updatetime = 200,    -- Slightly less aggressive
                    timer_interval = 200,
                    show_notifications = false,  -- Less noise during work
                },
                git = {
                    use_git_root = true,
                    auto_stage = false,  -- Don't auto-stage files
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
                    code = "--code",     -- Add code-focused mode
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
                    send_selection = "<leader>cs",  -- Send visual selection
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
