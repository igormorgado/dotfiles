-- Autocommands
local M = {}

function M.setup()
    -- Toggle relativenumber in insert mode
    vim.api.nvim_create_autocmd({ "InsertEnter" }, {
        pattern = "*",
        callback = function()
            vim.wo.relativenumber = false
        end
    })

    vim.api.nvim_create_autocmd({ "InsertLeave" }, {
        pattern = "*",
        callback = function()
            vim.wo.relativenumber = true
        end
    })

    -- Cursorline only in active window
    vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
        callback = function()
            vim.wo.cursorline = true
        end
    })
    vim.api.nvim_create_autocmd({ "WinLeave" }, {
        callback = function()
            vim.wo.cursorline = false 
        end 
    })


    -- Remember last position in file
    vim.api.nvim_create_autocmd("BufReadPost", {
        pattern = "*",
        callback = function()
            local last_pos = vim.fn.line("'\"")
            if last_pos > 0 and last_pos <= vim.fn.line("$") then
                vim.api.nvim_win_set_cursor(0, {last_pos, 0})
            end
            vim.defer_fn(function()
                if vim.api.nvim_get_mode().mode ~= 't' then
                    vim.cmd("normal! zvzz")
                end
            end, 10)
        end,
    })

    vim.api.nvim_create_autocmd(
        {
            'BufWinEnter',
            'WinEnter', 
            'VimResized', 
            'ColorScheme'
        },
        {
            pattern = '*',
            callback = _G.set_colored_columns,
        }
    )
end

return M
