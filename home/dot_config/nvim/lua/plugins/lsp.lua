-- LSP and completion plugins
return {
    {
        'L3MON4D3/LuaSnip',
        build = "make install_jsregexp"
    },

    {
        'hrsh7th/nvim-cmp',
        event = { "InsertEnter", "CmdlineEnter" },
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            -- 'hrsh7th/cmp-cmdline',
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip',
            'hrsh7th/cmp-nvim-lsp-signature-help',
            'hrsh7th/cmp-nvim-lua',
            'hrsh7th/cmp-calc',
            'f3fora/cmp-spell',
        },
        config = function()
            local cmp = require('cmp')
            local luasnip = require('luasnip')

            cmp.setup({
                performance = {
                    debounce = 100,
                    throttle = 50,
                    fetching_timeout = 200,
                    confirm_resolve_timeout = 80,
                    async_budget = 1,
                    max_view_entries = 50,
                },
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                formatting = {
                    expandable_indicator = true,
                    fields = { "kind", "abbr", "menu" },
                    format = function(entry, vim_item)
                        local kind_icons = {
                            Text = "󰉿", Method = "󰆧", Function = "󰊕",
                            Constructor = "", Field = "󰜢", Variable = "󰀫",
                            Class = "󰠱", Interface = "", Module = "",
                            Property = "󰜢", Unit = "󰑭", Value = "󰎠",
                            Enum = "", Keyword = "󰌋", Snippet = "",
                            Color = "󰏘", File = "󰈙", Reference = "󰈇",
                            Folder = "󰉋", EnumMember = "", Constant = "󰏿",
                            Struct = "󰙅", Event = "", Operator = "󰆕",
                            TypeParameter = "",
                        }
                        vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind)
                        vim_item.menu = ({
                            nvim_lsp = "[LSP]",
                            copilot = "[Copilot]",
                            luasnip = "[Snippet]",
                            buffer = "[Buffer]",
                            path = "[Path]",
                            nvim_lua = "[Lua]",
                            calc = "[Calc]",
                            spell = "[Spell]",
                        })[entry.source.name]
                        return vim_item
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-e>'] = cmp.mapping.abort(),
                    ['<CR>'] = cmp.mapping.confirm({
                        behavior = cmp.ConfirmBehavior.Replace,
                        select = false
                    }),
                    ['<Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expandable() then
                            luasnip.expand()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                    ['<S-Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
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
                    {
                        name = 'nvim_lsp',
                        priority = 1000,
                        entry_filter = function(entry, ctx)
                            return require('cmp.types').lsp.CompletionItemKind[entry:get_kind()] ~= 'Text'
                        end
                    },
                    { name = 'nvim_lsp_signature_help', priority = 1000 },
                    { name = 'copilot', priority = 900, group_index = 2 },
                    { name = 'luasnip', priority = 750, max_item_count = 5 },
                    { name = 'nvim_lua', priority = 500 },
                }, {
                    {
                        name = 'buffer',
                        priority = 250,
                        keyword_length = 3,
                        option = {
                            get_bufnrs = function()
                                return vim.api.nvim_list_bufs()
                            end
                        }
                    },
                    { name = 'path', priority = 250 },
                    { name = 'calc', priority = 150 },
                    { name = 'spell', priority = 100, keyword_length = 4 },
                }),
                experimental = {
                    ghost_text = true,
                },
            })
        end
    },

    {
        "neovim/nvim-lspconfig",
        dependencies = { "hrsh7th/cmp-nvim-lsp" },
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            local capabilities = require('cmp_nvim_lsp').default_capabilities()

            -- LSP keybindings
            local function on_attach(client, bufnr)
                local opts = { noremap = true, silent = true, buffer = bufnr }

                vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
                vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
                vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
                vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
                vim.keymap.set({ 'n', 'i' }, '<C-s>', vim.lsp.buf.signature_help, opts)
                vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder,
                    { desc = 'Code: Add workspace folder', buffer = bufnr, noremap = true, silent = true })
                vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder,
                    { desc = 'Code: Remove workspace folder', buffer = bufnr, noremap = true, silent = true })
                vim.keymap.set('n', '<leader>wl', function()
                    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                end, { desc = 'Code: List workspace folders', buffer = bufnr, noremap = true, silent = true })
                vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition,
                    { desc = 'Code: Type definition', buffer = bufnr, noremap = true, silent = true })
                vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename,
                    { desc = 'Code: Rename symbol', buffer = bufnr, noremap = true, silent = true })
                vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action,
                    { desc = 'Code: Actions', buffer = bufnr, noremap = true, silent = true })
                vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
                vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
                vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
            end

            ----------------------------------------------------------------------
            -- Helper: extend config + enable via vim.lsp.config / vim.lsp.enable
            ----------------------------------------------------------------------
            local function safe_setup(server_name, cfg)
                -- Decide which binary to check
                local cmd = cfg.cmd
                local bin = (cmd and cmd[1]) or server_name

                if vim.fn.executable(bin) ~= 1 then
                    vim.notify("LSP server '" .. bin .. "' not installed", vim.log.levels.WARN)
                    return
                end

                -- Merge into existing nvim-lspconfig defaults, if any
                vim.lsp.config(server_name, {
                    cmd = cfg.cmd,
                    filetypes = cfg.filetypes,
                    settings = cfg.settings,
                    capabilities = cfg.capabilities,
                    on_attach = cfg.on_attach,
                    init_options = cfg.init_options,
                })

                -- Enable this config so it auto-attaches on matching filetypes
                vim.lsp.enable(server_name)
            end

            ----------------------------------------------------------------------
            -- Servers
            ----------------------------------------------------------------------

            -- Python LSP (pylsp) – navigation and completion only
            safe_setup("pylsp", {
                capabilities = capabilities,
                on_attach = on_attach,
                filetypes = { "python" },
                settings = {
                    pylsp = {
                        plugins = {
                            -- Disable built-in linting (handled by nvim-lint + ruff)
                            flake8 = { enabled = false },
                            pylint = { enabled = false },
                            pycodestyle = { enabled = false },
                            pyflakes = { enabled = false },
                            mccabe = { enabled = false },

                            -- Disable formatting (handled by conform.nvim + ruff)
                            black = { enabled = false },
                            autopep8 = { enabled = false },
                            yapf = { enabled = false },

                            -- Keep completion and navigation features
                            jedi_completion = { enabled = true, fuzzy = true },
                            jedi_definition = { enabled = true, follow_imports = true },
                            jedi_references = { enabled = true },
                            jedi_symbols = { enabled = true, all_scopes = true },
                            rope_completion = { enabled = true },
                            rope_autoimport = { enabled = true },
                        }
                    }
                },
            })

            -- Lua LSP (lua-language-server)
            safe_setup("lua_ls", {
                capabilities = capabilities,
                on_attach = on_attach,
                cmd = { "lua-language-server" },
                filetypes = { "lua" },
                settings = {
                    Lua = {
                        runtime = {
                            version = 'LuaJIT',
                            path = vim.split(package.path, ';'),
                        },
                        diagnostics = {
                            globals = { 'vim' },
                        },
                        workspace = {
                            library = vim.api.nvim_get_runtime_file("", true),
                            checkThirdParty = false,
                        },
                        telemetry = {
                            enable = false,
                        },
                        completion = {
                            callSnippet = "Replace"
                        },
                    },
                },
            })

            -- TypeScript/JavaScript LSP (typescript-language-server)
            safe_setup("ts_ls", {
                capabilities = capabilities,
                on_attach = on_attach,
                cmd = { "typescript-language-server", "--stdio" },
                filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
                settings = {
                    typescript = {
                        inlayHints = {
                            includeInlayParameterNameHints = 'all',
                            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                            includeInlayFunctionParameterTypeHints = true,
                            includeInlayVariableTypeHints = true,
                            includeInlayPropertyDeclarationTypeHints = true,
                            includeInlayFunctionLikeReturnTypeHints = true,
                            includeInlayEnumMemberValueHints = true,
                        }
                    },
                    javascript = {
                        inlayHints = {
                            includeInlayParameterNameHints = 'all',
                            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                            includeInlayFunctionParameterTypeHints = true,
                            includeInlayVariableTypeHints = true,
                            includeInlayPropertyDeclarationTypeHints = true,
                            includeInlayFunctionLikeReturnTypeHints = true,
                            includeInlayEnumMemberValueHints = true,
                        }
                    }
                }
            })

            -- Bash LSP
            safe_setup("bashls", {
                capabilities = capabilities,
                on_attach = on_attach,
                cmd = { "bash-language-server", "start" },
                filetypes = { "sh", "bash" },
                settings = {
                    bashIde = {
                        globPattern = "*@(.sh|.inc|.bash|.command)"
                    }
                }
            })

            -- C/C++ LSP (clangd)
            safe_setup("clangd", {
                capabilities = capabilities,
                on_attach = on_attach,
                cmd = {
                    "clangd",
                    "--background-index",
                    "--clang-tidy",
                    "--header-insertion=iwyu",
                    "--completion-style=detailed",
                    "--function-arg-placeholders",
                    "--fallback-style=llvm",
                },
                init_options = {
                    usePlaceholders = true,
                    completeUnimported = true,
                    clangdFileStatus = true,
                },
                filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
            })
        end
    },
}
