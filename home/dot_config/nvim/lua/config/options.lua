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
    -- Cross-platform Python3 provider detection
    local function find_python3()
        -- Try nvim-specific virtual environments first
        local nvim_venv_paths = {
            vim.fn.expand('~/.pyenv/versions/nvim/bin/python3'),
            vim.fn.expand('~/.pyenv/versions/nvim/bin/python'),
            vim.fn.expand('~/.virtualenvs/nvim/bin/python3'),
            vim.fn.expand('~/.virtualenvs/nvim/bin/python'),
        }
        
        for _, path in ipairs(nvim_venv_paths) do
            if vim.fn.executable(path) == 1 then
                return path
            end
        end
        
        -- Fallback to system Python3 (avoid shims by using full path)
        local python3_candidates = {
            '/opt/homebrew/bin/python3',  -- Homebrew on macOS Apple Silicon
            '/usr/local/bin/python3',     -- Homebrew on macOS Intel
            '/usr/bin/python3',           -- System Python on Linux/macOS
            'python3',                    -- Last resort - use PATH
        }
        
        for _, candidate in ipairs(python3_candidates) do
            if vim.fn.executable(candidate) == 1 then
                return candidate
            end
        end
        
        return nil
    end
    
    local python3_path = find_python3()
    if python3_path then
        vim.g.python3_host_prog = python3_path
    end

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

    -- File persistence (swap/backup/undo) is configured in config.persistence
    vim.opt.writebackup = false

    -- Use `rg` if available locally
    if vim.fn.executable("rg") == 1 then
        vim.opt.grepprg = "rg --vimgrep --hidden --smart-case"
        vim.opt.grepformat = "%f:%l:%c:%m"
    end

    -- Performance optimizations
    vim.opt.lazyredraw = true        -- Don't redraw during macros
    vim.opt.synmaxcol = 300          -- Limit syntax highlighting column
    vim.opt.regexpengine = 1         -- Use old regex engine (sometimes faster)
    vim.opt.maxmempattern = 20000    -- Increase pattern matching memory
end

return M
