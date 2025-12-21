-- File format
vim.opt_local.fileformat = 'unix'
vim.opt_local.encoding = 'utf-8'

-- Spacing
vim.opt_local.tabstop = 4
vim.opt_local.softtabstop = 4
vim.opt_local.shiftwidth = 4
vim.opt_local.expandtab = true
vim.opt_local.autoindent = true

-- Buffer limits
vim.opt_local.wrap = false
vim.opt_local.linebreak = false
vim.opt_local.textwidth = 0

vim.keymap.set("n", "<localleader>ee", function()
  vim.cmd("update")  -- save file if modified
  local file = vim.fn.shellescape(vim.api.nvim_buf_get_name(0))
  vim.cmd(("split | terminal python %s"):format(file))
end, { buffer = true, silent = true, desc = "Execute: Run buffer in split terminal (Python 3)" })

-- Execute current Python file and wait for keypress
vim.keymap.set('n', '<leader>rr', function()
    local file = vim.fn.expand('%:p')
    vim.cmd('write')
    vim.cmd('vsplit | terminal python "' .. file .. '"; read -p "Press any key to continue..."')
end, { buffer = true, desc = 'Run current Python file' })

-- Folding: use Tree-sitter when folds query exists, otherwise indent
do
    local ok_parser, parser = pcall(vim.treesitter.get_parser, 0)
    local ok_query, folds = pcall(vim.treesitter.query.get, vim.bo.filetype, "folds")
    if ok_parser and ok_query and folds then
        vim.opt_local.foldmethod = 'expr'
        vim.opt_local.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
        pcall(function() parser:parse() end) -- ensure tree exists before first fold calc
    else
        vim.opt_local.foldmethod = 'indent'
    end
    vim.opt_local.foldenable = true
    vim.opt_local.foldlevel = 99
    vim.opt_local.foldlevelstart = 99
end
