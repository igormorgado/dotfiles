-- Core Neovim options and settings
local M = {}

function M.setup()
    -- Leader keys
    vim.g.mapleader = ' '
    vim.g.maplocalleader = ','

    -- Disable unused providers
    vim.g.loaded_ruby_provider = 0
    vim.g.loaded_node_provider = 0
    vim.g.loaded_perl_provider = 0
    vim.g.python3_host_prog = '~/.pyenv/versions/nvim/bin/python'

    -- Disable netrw (since we're using nvim-tree)
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    -- Basic UI configuration
    vim.opt.termguicolors = true
    vim.opt.mouse = 'a'
    vim.opt.number = true
    vim.opt.relativenumber = true
    vim.opt.cursorline = true
    vim.opt.cursorcolumn = true
    vim.opt.colorcolumn = '80,120'
    vim.opt.modeline = true
    vim.opt.modelines = 3
    vim.opt.scrolloff = 5
    vim.opt.sidescrolloff = 10

    -- Search settings
    vim.opt.ignorecase = true
    vim.opt.smartcase = true
    vim.opt.hlsearch = true

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
    vim.opt.textwidth = 79
    vim.opt.expandtab = true

    -- Apply colorscheme
    vim.cmd [[colorscheme darktrial]]

    -- Clipboard settings
    if vim.fn.has("macunix") == 1 then
        vim.opt.clipboard = "unnamedplus"
    elseif os.getenv("SSH_TTY") then
        vim.opt.clipboard = ""
    end
end

return M
