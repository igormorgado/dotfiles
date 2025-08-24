-- AI and code assistance plugins
return {
    {
        "github/copilot.vim",
        config = function()
            -- Enable Copilot for all filetypes
            vim.g.copilot_filetypes = {
                ["*"] = true,
            }
            
            -- Copilot keymaps
            -- vim.keymap.set('i', '<C-J>', 'copilot#Accept("\\<CR>")', {
            --     expr = true,
            --     replace_keycodes = false,
            --     desc = 'Accept Copilot suggestion'
            -- })
            -- vim.keymap.set('i', '<C-H>', '<Plug>(copilot-dismiss)', { desc = 'Dismiss Copilot suggestion' })
            -- vim.keymap.set('i', '<C-L>', '<Plug>(copilot-next)', { desc = 'Next Copilot suggestion' })
            -- vim.keymap.set('i', '<C-K>', '<Plug>(copilot-previous)', { desc = 'Previous Copilot suggestion' })
        end
    },
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
                    send_buffer = "<leader>cb",
                    send_visual = "<leader>cv",
                    ask_question = "<leader>cq",
                }
            })
            -- Enhanced keybindings for better Claude Code integration
            vim.keymap.set('n', '<leader>cc', '<cmd>ClaudeCode<CR>', { desc = 'AI: Toggle Claude Code' })
            vim.keymap.set('n', '<leader>cn', '<cmd>ClaudeCode new<CR>', { desc = 'AI: New Claude conversation' })
            vim.keymap.set('n', '<leader>cb', '<cmd>ClaudeCode --code<CR>', { desc = 'AI: Send buffer to Claude' })
            vim.keymap.set('n', '<leader>cj', '<cmd>ClaudeCode --continue<CR>', { desc = 'AI: Continue Claude conversation' })
            vim.keymap.set('n', '<leader>cx', '<cmd>ClaudeCode --quit<CR>', { desc = 'AI: Quit Claude session' })
            vim.keymap.set('n', '<leader>ch', '<cmd>ClaudeCode --help<CR>', { desc = 'AI: Claude help' })
            vim.keymap.set('n', '<leader>cr', '<cmd>ClaudeCode --resume<CR>', { desc = 'AI: Resume Claude session' })
            
            -- Visual mode bindings for sending selections
            vim.keymap.set('v', '<leader>cv', function()
                -- Get visual selection
                local mode = vim.fn.mode()
                if mode == 'v' or mode == 'V' then
                    -- Exit visual mode and get selection
                    vim.cmd('normal! ""gvy')
                    local selection = vim.fn.getreg('"')
                    
                    -- Open Claude Code if not already open
                    vim.cmd('ClaudeCode')
                    
                    -- Optional: Auto-insert the selection as a question
                    vim.defer_fn(function()
                        local claude_buf = vim.fn.bufnr('claude-code')
                        if claude_buf ~= -1 then
                            local prompt = "Please help me with this code:\n\n```\n" .. selection .. "\n```\n\n"
                            vim.api.nvim_buf_set_text(claude_buf, -1, 0, -1, 0, vim.split(prompt, '\n'))
                        end
                    end, 100)
                end
            end, { desc = 'AI: Send visual selection to Claude' })
            
            -- Quick access for common Claude Code workflows
            vim.keymap.set('n', '<leader>ce', function()
                local buf_name = vim.api.nvim_buf_get_name(0)
                local file_ext = vim.fn.fnamemodify(buf_name, ':e')
                local lang_context = ""
                
                if file_ext == "py" then
                    lang_context = "This is a Python file. "
                elseif file_ext == "lua" then
                    lang_context = "This is a Lua file for Neovim configuration. "
                elseif file_ext == "js" or file_ext == "ts" then
                    lang_context = "This is a JavaScript/TypeScript file. "
                end
                
                vim.cmd('ClaudeCode')
                vim.defer_fn(function()
                    local claude_buf = vim.fn.bufnr('claude-code')
                    if claude_buf ~= -1 then
                        local prompt = lang_context .. "Please explain this code:\n\n"
                        vim.api.nvim_buf_set_text(claude_buf, -1, 0, -1, 0, vim.split(prompt, '\n'))
                    end
                end, 100)
            end, { desc = 'AI: Explain current file with Claude' })
            
            vim.keymap.set('n', '<leader>cd', function()
                vim.cmd('ClaudeCode')
                vim.defer_fn(function()
                    local claude_buf = vim.fn.bufnr('claude-code')
                    if claude_buf ~= -1 then
                        local prompt = "Please review this code for potential bugs and improvements:\n\n"
                        vim.api.nvim_buf_set_text(claude_buf, -1, 0, -1, 0, vim.split(prompt, '\n'))
                    end
                end, 100)
            end, { desc = 'AI: Debug/review code with Claude' })
            
            vim.keymap.set('n', '<leader>ct', function()
                vim.cmd('ClaudeCode')
                vim.defer_fn(function()
                    local claude_buf = vim.fn.bufnr('claude-code')
                    if claude_buf ~= -1 then
                        local prompt = "Please write unit tests for this code:\n\n"
                        vim.api.nvim_buf_set_text(claude_buf, -1, 0, -1, 0, vim.split(prompt, '\n'))
                    end
                end, 100)
            end, { desc = 'AI: Generate tests with Claude' })
        end
    },
}
