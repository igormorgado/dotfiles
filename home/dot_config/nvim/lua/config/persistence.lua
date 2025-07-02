-- File persistence settings (swap, backup, undo)
local M = {}

function M.setup()
    -- Create directory structure for swap, backup, and undo
    local data_path = vim.fn.stdpath("data")
    local swap_dir = data_path .. "/swap"
    local backup_dir = data_path .. "/backup"
    local undo_dir = data_path .. "/undo"

    -- Create directories if they don't exist
    for _, dir in pairs({swap_dir, backup_dir, undo_dir}) do
        if not vim.loop.fs_stat(dir) then
            print("Creating " .. dir)
            vim.fn.mkdir(dir, "p")
        end
    end

    -- Configure backup, swap, and undo settings
    vim.opt.swapfile = true
    vim.opt.directory = swap_dir
    vim.opt.backup = true
    vim.opt.backupdir = backup_dir
    vim.opt.undofile = true
    vim.opt.undodir = undo_dir

    -- Configure how often to write swap files
    vim.opt.updatetime = 300
    vim.opt.updatecount = 80
end

return M