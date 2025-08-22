-- File format
vim.opt_local.fileformat = 'unix'
vim.opt_local.encoding = 'utf-8'

-- Spacing
vim.opt_local.tabstop = 4
vim.opt_local.softtabstop = 4
vim.opt_local.shiftwidth = 4
vim.opt_local.expandtab = true
vim.opt_local.autoindent = false

-- Buffer limits
vim.opt_local.wrap = false
vim.opt_local.linebreak = false
vim.opt_local.textwidth = 0

vim.keymap.set("n", "<localleader>ee", function()
  vim.cmd("update")  -- save file if modified
  local file = vim.fn.shellescape(vim.api.nvim_buf_get_name(0))
  vim.cmd(("split | terminal python3 %s"):format(file))
end, { buffer = true, silent = true, desc = "Execute: Run buffer in split terminal (Python 3)" })
