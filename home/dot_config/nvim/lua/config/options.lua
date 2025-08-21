-- Core Neovim options and settings
local M = {}

function M.setup()
    -- Leader keys
    vim.g.mapleader = ' '
    vim.g.maplocalleader = ','

    -- Disable unused providers
    vim.g.loaded_ruby_provider = 0
    -- vim.g.loaded_node_provider = 0
    vim.g.loaded_perl_provider = 0
    vim.g.python3_host_prog = vim.fn.expand('~/.pyenv/versions/nvim/bin/python')

    -- Disable netrw (since we're using nvim-tree)
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    -- Basic UI configuration
    vim.opt.termguicolors = true
    vim.opt.mouse = 'a'
    vim.opt.number = true
    vim.opt.relativenumber = true
    vim.opt.cursorline = true
    -- vim.opt.cursorcolumn = true
    vim.opt.cursorcolumn = false
    vim.opt.colorcolumn = '80,120'
    vim.opt.signcolumn = 'yes'
    vim.opt.splitright = true
    vim.opt.splitbelow = true
    vim.opt.scrolloff = 5
    vim.opt.sidescrolloff = 10
    vim.opt.updatetime = 200
    vim.opt.timeoutlen = 400

    vim.opt.modeline = true
    vim.opt.modelines = 3

    -- Search settings
    vim.opt.ignorecase = true
    vim.opt.smartcase = true
    vim.opt.hlsearch = true
    vim.opt.incsearch = true
    vim.opt.inccommand = 'split'


    -- Text display settings
    vim.opt.wrap = false
    vim.opt.breakindent = true
    vim.opt.linebreak = true

    -- List chars
    local default_listchars = { tab = "  ", extends = "⏵", precedes = "⏴" }
    vim.opt.list = true
    vim.opt.listchars = default_listchars

    -- Indentation settings
    vim.opt.tabstop = 4
    vim.opt.shiftwidth = 4
    vim.opt.expandtab = true
    -- no auto break in 79
    vim.opt.textwidth = 0

    -- Better completion UX
    vim.opt.completeopt = { "menuone", "noinsert", "noselect" }
    vim.opt.shortmess:append("cI")

    -- Apply colorscheme
    vim.cmd [[colorscheme darktrial]]

    -- Clipboard settings
    local on_ssh = vim.env.SSH_TTY ~= nil
    if vim.fn.has("clipboard") == 1 and not on_ssh then
        vim.opt.clipboard = "unnamedplus"
    else
        vim.opt.clipboard = ""
    end

    -- Use `rg` if available locally
    if vim.fn.executable("rg") == 1 then
        vim.opt.grepprg = "rg --vimgrep --hidden --smart-case"
        vim.opt.grepformat = "%f:%l:%c:%m"
    end
end

return M
