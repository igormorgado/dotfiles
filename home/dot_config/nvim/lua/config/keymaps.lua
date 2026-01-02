-- Global keymaps
local M = {}

function M.setup()
    local keymap = vim.keymap.set
    local opts = { noremap = true, silent = true }

    -- Quality of life mappings
    keymap('n', '<leader>a', ':keepjumps normal! ggVG<cr>', { desc = 'Select all' })
    keymap('n', '<leader>P', 'vipgqq', { desc = 'Paragraph flow' })
    keymap('n', '<leader>s', '<cmd>setlocal spell!<cr>', { desc = 'Toggle spellcheck' })
    keymap({ 'n', 'x' }, '<leader>y', '"+y', { desc = 'Yank to system clipboard' })
    keymap({ 'n', 'x' }, '<leader>p', '"+p', { desc = 'Paste from system clipboard' })
    keymap('n', '<leader><Space>', 'za', { desc = 'Fold: Toggle at cursor' })

    -- Quick mapping: clear search highlight fast
    vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR><Esc>')

    -- Terminal escape
    keymap('t', '<leader><esc>', '<C-\\><C-n>', { desc = 'Escape from Terminal insert mode' })

    -- Window navigation + resizing now provided by smart-splits (see lua/plugins/ui.lua)

    -- Tab navigation
    for i = 1, 9 do
        keymap('n', '<leader>' .. i, i .. 'gt', vim.tbl_extend('force', opts, { desc = 'Go to tab ' .. i }))
    end

    -- Toggle listchars
    local default_listchars = { tab = "  ", extends = "⏵", precedes = "⏴" }
    local extended_listchars = { eol = "↲", nbsp = "␣", trail = "•", extends = "⏵", precedes = "⏴", tab = "⟶ " }
    local show_extra = false

    local function toggle_list()
        if show_extra then
            vim.opt.listchars = extended_listchars
        else
            vim.opt.listchars = default_listchars
        end
        show_extra = not show_extra
    end

    keymap('n', '<leader>l', toggle_list, { desc = 'Toggle list' })


    -- Toggle column highlight on demand (when you actually need it)
    keymap('n', '<leader>o', function()
        vim.opt.cursorcolumn = not vim.opt.cursorcolumn:get()
        print("Cursorcolumn: " .. tostring(vim.opt.cursorcolumn:get()))
    end, { desc = "Toggle cursorcolumn" })

    -- Cleanup utilities
    keymap('n', '<leader>tw', function()
        local save_cursor = vim.fn.getpos(".")
        vim.cmd('%s/\\s\\+$//ge')
        vim.fn.setpos(".", save_cursor)
        vim.cmd('write')
    end, { desc = 'Remove trailing whitespace and save' })

    -- Better buffer navigation (now handled by bufferline)
    keymap('n', '<leader>bd', '<cmd>bdelete<CR>', { desc = 'Delete buffer' })
    keymap('n', '<leader>ba', '<cmd>%bdelete|edit#<CR>', { desc = 'Delete all buffers but current' })

    -- Jupyter cell navigation (vim-unimpaired style)
    keymap('n', ']j', function()
        vim.fn.search("^# .* %%$", "W")
    end, { desc = 'Jump to next jupyter cell' })
    keymap('n', '[j', function()
        vim.fn.search("^# .* %%$", "bW")
    end, { desc = 'Jump to previous jupyter cell' })

end

return M
