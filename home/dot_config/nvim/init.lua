------------------------------------------------------------------------------
-- CORE SETTINGS
------------------------------------------------------------------------------
-- Leader keys
vim.g.mapleader = ' '
vim.g.maplocalleader = ','

-- Disable unused providers
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.python3_host_prog = '~/.pyenv/versions/nvim/bin/pytho'

-- Disable netrw (since we're using nvim-tree)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Shell configuration (do not enforce shell)
-- local FISH_SHELL = os.getenv('FISH_SHELL')
-- if FISH_SHELL then
--     vim.opt.shell = FISH_SHELL
-- end

------------------------------------------------------------------------------
-- UI SETTINGS
------------------------------------------------------------------------------
-- Basic UI configuration
vim.opt.termguicolors = true
vim.opt.mouse = 'a'
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.cursorcolumn = true
vim.opt.colorcolumn = '80'
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

-- List chars
local default_listchars = { tab = "  ", extends = "⏵", precedes = "⏴" }
local extended_listchars = { eol = "↲", nbsp = "␣", trail = "•", extends = "⏵", precedes = "⏵", tab = "⟶ " }
local show_extra = false
vim.opt.list = true
vim.opt.listchars = default_listchars

-- Toggle listchars
function ToggleList()
    if show_extra then
        vim.opt.listchars = extended_listchars
    else
        vim.opt.listchars = default_listchars
    end
    show_extra = not show_extra
    -- vim.opt.list = not vim.opt.list:get()
end
vim.keymap.set('n', '<leader>l', '<cmd>lua ToggleList()<CR>', { noremap = true, silent = true, desc = 'Toggle list' })

-- Indentation settings
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.textwidth = 79
vim.opt.expandtab = true

-- Apply colorscheme after options but before plugins
vim.cmd [[colorscheme darktrial]]

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

------------------------------------------------------------------------------
-- FILE PERSISTENCE SETTINGS
------------------------------------------------------------------------------
-- Create directory structure for swap, backup, and undo
local data_path = vim.fn.stdpath("data")
local swap_dir = data_path .. "/swap"
local backup_dir = data_path .. "/backup"
local undo_dir = data_path .. "/undo"

-- Create directories if they don't exist
for _, dir in pairs({swap_dir, backup_dir, undo_dir}) do
    if not vim.loop.fs_stat(dir) then
        print("Creating" .. dir)
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

-- Remember last position in file
vim.api.nvim_create_autocmd("BufReadPost", {
    pattern = "*",
    callback = function()
        local last_pos = vim.fn.line("'\"")
        if last_pos > 0 and last_pos <= vim.fn.line("$") then
            vim.api.nvim_win_set_cursor(0, {last_pos, 0})
        end
        vim.defer_fn(function()
            vim.cmd("normal! zvzz")
        end, 10)
    end,
})

------------------------------------------------------------------------------
-- CLIPBOARD SETTINGS
------------------------------------------------------------------------------
if vim.fn.has("macunix") == 1 then
    vim.opt.clipboard = "unnamedplus"
elseif os.getenv("SSH_TTY") then
    vim.opt.clipboard = ""
end

-----------------------------------------------------------------------------
-- AI STUFF
-----------------------------------------------------------------------------
local model_name = "deepseek-coder:6.7b-instruct-q4_K_M"

------------------------------------------------------------------------------
-- PLUGIN MANAGER SETUP (LAZY.NVIM)
------------------------------------------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.runtimepath:prepend(lazypath)

------------------------------------------------------------------------------
-- PLUGIN CONFIGURATIONS
------------------------------------------------------------------------------
require("lazy").setup({
    -- UI Improvements
    { 'nvim-lualine/lualine.nvim',
        event = "VeryLazy",
        config = function()
	    vim.opt.showmode = false
            local function dynamic_path()
                -- Get current working directory
                local cwd = vim.fn.getcwd()
                -- Full absolute path
                local full_path = vim.fn.expand('%:p')
                -- Make it relative to cwd
                local relative_path = vim.fn.fnamemodify(full_path, ':~:.')
                -- Shorten directory names
                local short_path = vim.fn.pathshorten(relative_path)
                -- get only the filename
                local filename = vim.fn.fnamemodify(full_path, ':t')
                -- Get current window width
                local win_width = vim.api.nvim_win_get_width(0)

                if win_width < 70 then
                    return filename
                elseif win_width < 80 then
                    return short_path
                else
                    return relative_path
                end
            end

            local function lsp_status()
                local clients = vim.lsp.get_clients({ bufnr = 0 })
                -- local clients = vim.lsp.get_active_clients({ bufnr = 0 })
                if #clients == 0 then
                    return ''
                end
                local client_names = {}
                for _, client in ipairs(clients) do
                    -- Map common LSP server names to shorter versions or icons
                    local name = client.name
                    if name == 'pyright' then
                        name = 'Py'
                    elseif name == 'clangd' then
                        name = 'C/C++'
                    elseif name == 'tsserver' then
                        name = 'TS'
                    elseif name == 'lua_ls' then
                        name = 'Lua'
                    elseif name == 'pylsp' then
                        name = 'Plsp'
                    end
                    table.insert(client_names, name)
                end
                return ' ' .. table.concat(client_names, ', ')
            end

            require('lualine').setup({
                options = { icons_enabled = true, },
                sections = {
                    lualine_a = { 'mode' },
                    lualine_b = { 'branch', 'diff', 'diagnostics' },
                    lualine_c = { dynamic_path },
                    lualine_x = { { lsp_status }, 'encoding', 'fileformat', 'filetype' },
                    lualine_y = { 'progress' },
                    lualine_z = { 'location' }
                } 
            })
        end
    },


    {
      "RRethy/vim-hexokinase",
      -- run the build step after install/update
      build = "make hexokinase",
      config = function()
        -- { "sign_column" }, { "background" }, { "foreground" }, etc.
        vim.g.Hexokinase_highlighters = { "virtual" }
        vim.g.Hexokinase_ftOptInPatterns = {
            fish = "full_hex,rgb,colour_names"
        }
        -- turn on the colouring immediately
        vim.cmd("HexokinaseTurnOn")
      end,
    },

    -- File explorer
    { "nvim-tree/nvim-tree.lua",
        lazy = false,
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("nvim-tree").setup({
                sort = { sorter = "case_sensitive" },
                view = { width = 40 },
                renderer = { group_empty = true },
                filters = { dotfiles = true },
            })
            vim.keymap.set('n', '-', '<cmd>NvimTreeFocus<cr>', { desc = 'Open file browser' })
        end
    },

    -- Git integration
    { "lewis6991/gitsigns.nvim", 
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require('gitsigns').setup({
                signs = {
                    add          = { text = '┃' },
                    change       = { text = '┃' },
                    delete       = { text = '_' },
                    topdelete    = { text = '‾' },
                    changedelete = { text = '~' },
                    untracked    = { text = '┆' },
                },
                signcolumn = true,
                numhl      = false,
                linehl     = false,
                word_diff  = false,
                watch_gitdir = {
                    follow_files = true
                },
                auto_attach = true,
                attach_to_untracked = false,
                current_line_blame = false,
                current_line_blame_opts = {
                    virt_text = true,
                    virt_text_pos = 'eol',
                    delay = 1000,
                    ignore_whitespace = false,
                    virt_text_priority = 100,
                },
                current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
                sign_priority = 6,
                update_debounce = 100,
                status_formatter = nil,
                max_file_length = 40000,
                preview_config = {
                    border = 'single',
                    style = 'minimal',
                    relative = 'cursor',
                    row = 0,
                    col = 1
                },
            })
        end
    },

    { "tpope/vim-fugitive", event = "VeryLazy" },

    { "NeogitOrg/neogit",
        cmd = "Neogit",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "sindrets/diffview.nvim",
            "ibhagwan/fzf-lua",
        },
        config = function()
            require("neogit").setup({
                graph_style = "unicode",
            })
        end
    },

    { "David-Kunz/gen.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        event = "VeryLazy",
        config = function()
            require("gen").setup({
                model = model_name,
                -- Display response in a floating window
                display_mode = "vsplit",
                -- Show the model name in the output
                show_model = true,
                -- Don't auto-close the window
                no_auto_close = true,
            })
            if vim.fn.executable("ollama") == 1 then
                vim.fn.jobstart("pgrep ollama || ollama serve > /dev/null 2>&1 &")
            end

            local prompts = require("gen").prompts
            prompts['Fix_Code'] = { prompt = "Fix the following code. Only output the result in format ```$filetype\n...\n```:\n```$filetype\n$text\n```", replace = true, extract = "```$filetype\n(.-)```" }
            prompts["explain"] =  { prompt = "Explain the following code in detail:\n\n```$filetype\n$text\n```", replace = false }
            prompts["refactor"] = { prompt = "Refactor the following code to improve its clarity, efficiency, and maintainability:\n\n```$filetype\n$text\n```\n\nProvide only the refactored code without explanations.", replace = true }
            prompts["document"] = { prompt = "Add comprehensive documentation to the following code:\n\n```$filetype\n$text\n```\n\nProvide the documented code.", replace = false}
            prompts["tests"] =    { prompt = "Generate unit tests for the following code:\n\n```$filetype\n$text\n```", replace = false}
            prompts["optimize"] = { prompt = "Optimize the following code for better performance:\n\n```$filetype\n$text\n```\n\nProvide only the optimized code.", replace = false }
            prompts["complete"] = { prompt = "Complete the following code snippet:\n\n```$filetype\n$text\n```\n\nProvide only the completion, not the original code.", replace = false }
            local map_opts = { noremap = true, silent = true }
            vim.keymap.set("v", "<leader>gg", ":Gen<CR>",          map_opts)     -- Generate from selection
            vim.keymap.set("n", "<leader>gg", ":Gen<CR>",          map_opts)     -- Ask in normal mode
            vim.keymap.set("n", "<leader>gc", ":Gen Chat<CR>",     map_opts)
            vim.keymap.set("v", "<leader>ge", ":Gen explain<CR>",  map_opts)     -- Explain code
            vim.keymap.set("v", "<leader>gr", ":Gen refactor<CR>", map_opts)     -- Refactor code
            vim.keymap.set("v", "<leader>gd", ":Gen document<CR>", map_opts)     -- Document code
            vim.keymap.set("v", "<leader>gt", ":Gen tests<CR>",    map_opts)     -- Generate tests
            vim.keymap.set("v", "<leader>go", ":Gen optimize<CR>", map_opts)     -- Optimize code
            vim.keymap.set("n", "<leader>gC", ":Gen complete<CR>", map_opts)     -- Complete code

        end
    },

    { 'L3MON4D3/LuaSnip',
      -- run the build step after install/update
      build = "make install_jsregexp"
    },

    -- LSP and completion
    { 'hrsh7th/nvim-cmp',
        event = { "InsertEnter", "CmdlineEnter" },
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip',
            'hrsh7th/cmp-nvim-lsp-signature-help',
        },
        config = function()
            local cmp = require('cmp')
            local luasnip = require('luasnip')

            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-n>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                    ['<C-p>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                }),
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'nvim_lsp_signature_help' },
                    { name = 'luasnip' },
                }, {
                        { name = 'buffer' },
                        { name = 'path' },
                    }),
            })

            -- Use buffer source for `/` and `?`
            cmp.setup.cmdline({ '/', '?' }, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = 'buffer' }
                }
            })

            -- Use cmdline & path source for ':'
            cmp.setup.cmdline(':', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = 'path' }
                }, {
                        { name = 'cmdline' }
                    })
            })
        end
    },

    { "neovim/nvim-lspconfig",
        dependencies = { "hrsh7th/cmp-nvim-lsp" },
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            local capabilities = require('cmp_nvim_lsp').default_capabilities()

            require("lspconfig").pylsp.setup({
                capabilities = capabilities,
                settings = {
                    pylsp = {
                        plugins = {
                            -- pycodestyle = { enabled = true, maxLineLength = 119 },
                            -- pyflakes = { enabled = true },
                            flake8 = { enabled = true, maxLineLength = 119 },
                            jedi_completion = { enable = true },
                            jedi_definition = { enable = true },
                            jedi_references = { enable = true },
                            jedi_symbols = { enable = true, all_scopes = true },
                            rope_completion = { enabled = true },
                            rope_autoimport = { enabled = true },
                        }
                    }
                },    
                on_attach = function(client, bufnr)
                    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
                    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
                    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
                    local opts = { noremap = true, silent = true }
                    buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
                    buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
                    buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
                    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
                    buf_set_keymap('n', '<C-s>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
                    buf_set_keymap('i', '<C-s>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
                    buf_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
                    buf_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
                    buf_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
                    buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
                    buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
                    buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
                    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
                    buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
                    buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)

                    -- Add this for explicit signature help binding
                    -- vim.keymap.set({ 'n', 'i' }, '<C-s>', vim.lsp.buf.signature_help, { buffer = bufnr, desc = "Show signature help" })
                end
            })
        end
    },

    -- Fuzzy finding
    { 'nvim-telescope/telescope.nvim', 
        lazy = false,
        cmd = "Telescope",
        dependencies = { 'nvim-lua/plenary.nvim' }, 
        config = function()
            local builtin = require('telescope.builtin')
            local telescope_mappings = {
                ['<leader>ff'] = { builtin.find_files, 'Telescope find files' },
                ['<leader>fg'] = { builtin.live_grep, 'Telescope live grep' },
                ['<leader>fb'] = { builtin.buffers, 'Telescope buffers' },
                ['<leader>fh'] = { builtin.help_tags, 'Telescope help tags' }
            }
            local keymap_opts = { noremap = true, silent = true }
            for key, mapping in pairs(telescope_mappings) do
                local opts = vim.tbl_extend("force", keymap_opts, { desc =  mapping[2] })
                vim.keymap.set('n', key, mapping[1], opts)
            end
        end
    },

    { 'ibhagwan/fzf-lua',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        cmd = "FzfLua",
        keys = {
            { "<leader>t", "<cmd>lua require('fzf-lua').files()<CR>", silent = true, desc="Fuzzy finder" },
            { "<leader>b", "<cmd>lua require('fzf-lua').buffers()<CR>", silent = true, desc="Fuzzy buffers" },
            { "<C-x><C-f>", function() require("fzf-lua").complete_path() end, silent = true, desc = "Fuzzy complete path", mode = { "n", "v", "i" } },
        },
        config = function()
            require('fzf-lua').setup({})
        end
    },

    -- Treesitter for better syntax highlighting and code navigation
    { "nvim-treesitter/nvim-treesitter", 
        event = { "BufReadPost", "BufNewFile" }, 
        build = ":TSUpdate", 
        config = function()
            local treesitter_parser_install_dir = vim.fn.stdpath("data") .. "/treesitter"
            require("nvim-treesitter.configs").setup({
                parser_install_dir = treesitter_parser_install_dir,
                ensure_installed = {
                    -- Uncomment languages you want to ensure are installed
                    -- "python", "c", "vim", "javascript", "sql", "vimdoc",
                    -- "html", "query", "css", "lua", "markdown", "markdown_inline", 
                },
                auto_install = true,
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = "gnn",
                        node_incremental = "grn",
                        scope_incremental = "grc",
                        node_decremental = "grm",
                    },
                },
                indent = {
                    enable = true
                },
                fold = {
                    enable = true
                },
            })
            vim.opt.runtimepath:append(treesitter_parser_install_dir)
            vim.keymap.set('n', '<leader>vs', function()
                require('nvim-treesitter.incremental_selection').init_selection()
                require('nvim-treesitter.incremental_selection').scope_incremental()
            end, { desc = "Select entire scope" })
            vim.wo.foldmethod = "expr"
            vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
        end
    },

    { "nvim-treesitter/nvim-treesitter-context", opts = { enable = true, max_lines = 3 } },

    -- Document formatting and editing improvements
    { "folke/trouble.nvim", opts = {}, cmd = "Trouble", 
        keys = {
            { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
            { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
            { "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols (Trouble)" },
            { "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "LSP Definitions / references / ... (Trouble)" },
            { "<leader>xl", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
            { "<leader>xq", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
        },
    },

    { "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        ---@module "ibl"
        ---@type ibl.config
        opts = {},
        config = function()
            -- local highlight = {
            --    "Whitespace",
            --    -- "CursorColumn",
            -- }
            require("ibl").setup {
                -- indent = { highlight = highlight, char = "▎" },
                -- whitespace = {
                --     highlight = highlight,
                --     remove_blankline_trail = false,
                -- },
                scope = { enabled = true },
            }
        end
    }, 

    { 'preservim/vim-markdown', dependencies = { 'godlygeek/tabular' }, ft = 'markdown' },

    -- Python-specific plugins
    { "geg2102/nvim-python-repl",
        dependencies = "nvim-treesitter",
        ft = { "python" }, 
        config = function()
            require("nvim-python-repl").setup({ execute_on_send = true, vsplit = false, })
            local repl_mappings = {
                ['<leader>eb'] = { "send_buffer_to_repl", "Send entire buffer to REPL" },
                ['<leader>ee'] = { "send_statement_definition", "Send semantic unit to REPL" },
                ['<leader>E']  = { "send_visual_to_repl", "Send visual selection to REPL" },
                ['<leader>ct'] = { "toggle_execute", "Automatically execute command in REPL after sent" },
                ['<leader>lv'] = { "toggle_vertical", "Create REPL in vertical or horizontal split" },
                ['<leader>ls'] = { "open_repl", "Opens the REPL in a window split" }
            }
            for key, command in pairs(repl_mappings) do
                vim.keymap.set("n", key, function() require("nvim-python-repl")[command[1]]() end, { desc = command[2] })
            end
        end
    },

    -- LaTeX support
    { 'lervag/vimtex',
        ft = { 'tex', 'latex' },
        init = function()
            vim.g.vimtex_compiler_method = 'latexmk'
            vim.g.vimtex_view_method = 'zathura'
            vim.keymap.set('n', '<localleader>v', '<plug>(vimtex-view)', { desc='View PDF' })
            vim.keymap.set('n', '<localleader>lt', '<cmd>VimtexTocToggle<cr>', { desc='Toggle VimTeX ToC' })
        end,
    },

    -- Utility plugins
    { 'konfekt/vim-DetectSpellLang',
        event = "VeryLazy",
        init = function()
            vim.g.detectspelllang_langs = { 
                aspell = { 'en_US', 'en', 'pt_BR', 'es', 'fr_FR', 'fr' }, 
                hunspell =  { 'en_US', 'pt_BR', 'es_ES', 'es_MX', 'fr_FR' }, 
            }
        end,
    },

    { "mbbill/undotree", 
        cmd = "UndotreeToggle", 
        keys = { 
            { "<leader>u", "<cmd>UndotreeToggle<CR>", desc = "Toggle Undo Tree" } 
        } 
    },

    { "lifepillar/vim-colortemplate", lazy = false },

    -- Tim Pope's quality of life plugins
    { 'tpope/vim-unimpaired', event = "VeryLazy" },

    -- Miscellaneous plugins
    { 'kshenoy/vim-signature', event = "VeryLazy" },

    -- Kitty integration
    -- { "MunsMan/kitty-navigator.nvim",
    --     build = {
    --         "cp -f navigate_kitty.py ~/.config/kitty",
    --         "cp -f pass_keys.py ~/.config/kitty",
    --     },
    --     opts = {
    --         keybindings = {},
    --         keys = {
    --             {"<C-h>", function()require("kitty-navigator").navigateLeft()end, desc = "Move left a Split", mode = {"n"}},
    --             {"<C-j>", function()require("kitty-navigator").navigateDown()end, desc = "Move down a Split", mode = {"n"}},
    --             {"<C-k>", function()require("kitty-navigator").navigateUp()end, desc = "Move up a Split", mode = {"n"}},
    --             {"<C-l>", function()require("kitty-navigator").navigateRight()end, desc = "Move right a Split", mode = {"n"}},
    --         },
    --     }
    -- },

    -- { 
    --     'knubie/vim-kitty-navigator',
    --     lazy = false,
    --     build = "cp ./*.py ~/.config/kitty/",
    --     cond = function()
    --         return os.getenv("KITTY_WINDOW_ID") or string.match(os.getenv("TERM"), "^xterm%-kitty")
    --     end
    -- },

})

------------------------------------------------------------------------------
-- GLOBAL KEYMAPS
------------------------------------------------------------------------------
-- Quality of life mappings
vim.keymap.set('n', '<leader>a', ':keepjumps normal! ggVG<cr>', { desc = 'Select all' })
vim.keymap.set('n', '<leader>w', '<cmd>write<cr>', { desc = 'Save' })
vim.keymap.set('n', '<leader>P', 'vipgqq', { desc = 'Paragraph flow' })
vim.keymap.set('n', '<leader>s',  '<cmd>setlocal spell!<cr>', { desc = 'Toggle spellcheck' })
vim.keymap.set({ 'n', 'x' }, '<leader>y', '"+y', { desc = 'Yank to system clipboard' })
vim.keymap.set({ 'n', 'x' }, '<leader>p', '"+p', { desc = 'Paste from system clipboard' })

-- Window/buffer/tab navigation
vim.keymap.set('t', '<leader><esc>', '<C-\\><C-n>', { desc = 'Escape from Terminal insert mode' })
-- vim.keymap.set({ 'n', 't', 'v' }, '<C-_>', '<C-w><C-_>', { desc = 'Maximize horizontally' })
-- vim.keymap.set({ 'n', 't', 'v' }, '<C-|>', '<C-w><C-|>', { desc = 'Maximize vertically' })
vim.keymap.set({ 'n', 't', 'v' }, '<C-h>', '<C-w><C-h>', { desc = 'Go Left Panel' })
vim.keymap.set({ 'n', 't', 'v' }, '<C-j>', '<C-w><C-j>', { desc = 'Go Down Panel' })
vim.keymap.set({ 'n', 't', 'v' }, '<C-k>', '<C-w><C-k>', { desc = 'Go Up Panel' })
vim.keymap.set({ 'n', 't', 'v' }, '<C-l>', '<C-w><C-l>', { desc = 'Go Right Panel' })
-- vim.keymap.set('i', '<C-_>', '<esc><C-w><C-_>i', { desc = 'Maximize horizontally' })
-- vim.keymap.set('i', '<C-|>', '<esc><C-w><C-|>i', { desc = 'Maximize vertically' })
vim.keymap.set('i', '<C-h>', '<esc><C-w><C-h>i', { desc = 'Go Left Panel' })
vim.keymap.set('i', '<C-j>', '<esc><C-w><C-j>i', { desc = 'Go Down Panel' })
vim.keymap.set('i', '<C-k>', '<esc><C-w><C-k>i', { desc = 'Go Up Panel' })
vim.keymap.set('i', '<C-l>', '<esc><C-w><C-l>i', { desc = 'Go Right Panel' })

-- Window resizing
vim.keymap.set('n', '<M-l>', ':vertical resize +1<CR>', { noremap = true, silent = true, desc = 'Enlarge window horizontally' })
vim.keymap.set('n', '<M-h>', ':vertical resize -1<CR>', { noremap = true, silent = true, desc = 'Reduce window horizontally' })
vim.keymap.set('n', '<M-k>', ':resize +1<CR>', { noremap = true, silent = true, desc = 'Enlarge window vertically' })
vim.keymap.set('n', '<M-j>', ':resize -1<CR>', { noremap = true, silent = true, desc = 'Reduce window vertically' })

-- Tab navigation
for i = 1, 9 do
    vim.keymap.set('n', '<leader>' .. i, i .. 'gt', { noremap = true, silent = true, desc = 'Go to tab ' .. i })
end

------------------------------------------------------------------------------
-- CUSTOM COMMANDS
------------------------------------------------------------------------------
-- Add command to quickly delete swap files for current buffer
vim.api.nvim_create_user_command('DeleteSwap', function()
    local swapfile = vim.fn.swapname(vim.fn.expand('%:p'))
    if swapfile ~= '' and vim.fn.filereadable(swapfile) == 1 then
        vim.fn.delete(swapfile)
        vim.notify("Deleted swap file: " .. swapfile, vim.log.levels.INFO)
    else
        vim.notify("No swap file found", vim.log.levels.WARN)
    end
end, {})

-- Keybinding for DeleteSwap command
vim.keymap.set('n', '<leader>ds', '<cmd>DeleteSwap<CR>', { desc = 'Delete swap file for current buffer' })

-- Alternative function using treesitter
function _G.ts_syntax_at_point()
  local bufnr = vim.api.nvim_get_current_buf()
  local cursor = vim.api.nvim_win_get_cursor(0)
  local row, col = cursor[1] - 1, cursor[2]
  
  -- Get treesitter parser
  local parsers = require('nvim-treesitter.parsers')
  if not parsers.has_parser() then
    print("No treesitter parser available for this buffer")
    return
  end
  
  local parser = vim.treesitter.get_parser(bufnr)
  local tree = parser:parse()[1]
  local root = tree:root()
  
  -- Get node at cursor
  local node = root:named_descendant_for_range(row, col, row, col)
  
  if node then
    local node_type = node:type()
    print("Treesitter node: " .. node_type)
    
    -- Try to get highlight capture
    local ts_utils = require('nvim-treesitter.ts_utils')
    local hl_groups = vim.treesitter.highlighter.hl_map
    if hl_groups then
      print("Highlight group: " .. vim.inspect(hl_groups[node_type] or "unknown"))
    end
  else
    print("No treesitter node at cursor position")
  end
end

-- Create a keymap to call the function
vim.keymap.set('n', '<F12>', _G.ts_syntax_at_point, {noremap = true})



-- Toggleable Typewriter Scrolling for Neovim
-- Place this in your init.lua or a separate Lua module

-- State storage in the global namespace
vim.g.typewriter_mode = false
vim.g.typewriter_saved = {}

-- The toggle function
function _G.toggle_typewriter()
  if not vim.g.typewriter_mode then
    -- Save original settings
    vim.g.typewriter_saved.scrolloff    = vim.wo.scrolloff
    vim.g.typewriter_saved.sidescrolloff = vim.wo.sidescrolloff

    -- Compute half the window height (minus one so the cursor truly stays centered)
    local h = vim.api.nvim_win_get_height(0)
    local half = math.floor(h / 2)

    -- Enable typewriter mode
    vim.wo.scrolloff = half
    vim.wo.sidescrolloff = 0
    vim.g.typewriter_mode = true
    vim.notify("Typewriter mode ON (cursor stays centered)", vim.log.levels.INFO)
  else
    -- Restore original settings
    vim.wo.scrolloff = vim.g.typewriter_saved.scrolloff
    vim.wo.sidescrolloff = vim.g.typewriter_saved.sidescrolloff
    vim.g.typewriter_mode = false
    vim.notify("Typewriter mode OFF", vim.log.levels.INFO)
  end
end

-- Keymap: <Leader>t to toggle
vim.keymap.set(
  "n",
  "<localleader>t",
  _G.toggle_typewriter,
  { noremap = true, silent = true, desc = "Toggle typewriter scroll mode" }
)

------------------------------------------------------------------------------
-- NEOVIDE GUI SETTINGS
------------------------------------------------------------------------------
if vim.g.neovide then
    -- Font settings
    vim.opt.guifont = "Fira Code:h10"
    vim.opt.linespace = 4

    -- Padding and appearance
    vim.g.neovide_padding_top = 6
    vim.g.neovide_padding_bottom = 6
    vim.g.neovide_padding_right = 6
    vim.g.neovide_padding_left = 6

    -- Visual effects
    vim.g.neovide_floating_blur_amount_x = 2.0
    vim.g.neovide_floating_blur_amount_y = 2.0
    vim.g.neovide_floating_shadow = true
    vim.g.neovide_floating_z_height = 10
    vim.g.neovide_light_angle_degrees = 45
    vim.g.neovide_light_radius = 5
    vim.g.neovide_opacity = 0.99
    vim.g.neovide_hide_mouse_when_typing = true
    vim.g.neovide_theme = "auto"
    vim.g.neovide_cursor_vfx_mode = "pixiedust"

    -- Performance settings
    vim.g.neovide_refresh_rate = 120
    vim.g.neovide_refresh_rate_idle = 5
    vim.g.neovide_remember_window_size = true
    vim.g.neovide_profiler = false

    -- Zoom functionality
    vim.g.neovide_scale_factor = 1.0
    local change_scale_factor = function(delta)
        vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
    end
    vim.keymap.set("n", "<C-=>", function()
        change_scale_factor(1.25)
    end)
    vim.keymap.set("n", "<C-->", function()
        change_scale_factor(1/1.25)
    end)
end
