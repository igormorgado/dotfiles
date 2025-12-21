local ok_parser, parser = pcall(vim.treesitter.get_parser, 0)
local ok_query, folds = pcall(vim.treesitter.query.get, vim.bo.filetype, "folds")

if ok_parser and ok_query and folds then
    vim.opt_local.foldmethod = 'expr'
    vim.opt_local.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    pcall(function() parser:parse() end) -- prime fold cache with a parsed tree
else
    vim.opt_local.foldmethod = 'indent'
end

vim.opt_local.foldenable = true
vim.opt_local.foldlevel = 99
vim.opt_local.foldlevelstart = 99
