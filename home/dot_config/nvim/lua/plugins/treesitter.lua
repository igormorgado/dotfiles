-- Treesitter (Neovim 0.11+): parsers, queries, and integrations
return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        lazy = false, -- upstream explicitly does not support lazy-loading
        build = ":TSUpdate",
        config = function()
            local install_dir = vim.fn.stdpath("data") .. "/treesitter"
            local ensured = {
                "python",
                "c",
                "vim",
                "javascript",
                "sql",
                "vimdoc",
                "html",
                "query",
                "css",
                "lua",
                "markdown",
                "markdown_inline",
                "json",
                "jsonc",
                "yaml",
            }

            local ts = require("nvim-treesitter")
            ts.setup({ install_dir = install_dir })
            vim.opt.runtimepath:prepend(install_dir)

            -- Ensure a baseline set of parsers exists (no-op if already installed)
            ts.install(ensured)

            local attempted_auto_install = {}

            local function buf_lang(bufnr)
                local ft = vim.bo[bufnr].filetype
                if ft == "" then
                    return nil
                end
                return vim.treesitter.language.get_lang(ft) or ft
            end

            local function ensure_parser(lang)
                if not lang or lang == "" or attempted_auto_install[lang] then
                    return
                end
                attempted_auto_install[lang] = true
                pcall(ts.install, { lang })
            end

            local function enable_indentexpr_if_available(bufnr, lang)
                local ok_query, query = pcall(vim.treesitter.query.get, lang, "indents")
                if ok_query and query then
                    -- NOTE: Neovim expects these quotes exactly (per :h nvim-treesitter)
                    vim.bo[bufnr].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                end
            end

            -- Replacement for the removed nvim-treesitter "incremental_selection" module.
            -- Keeps existing keymaps and behavior without retro-compat concerns.
            local selection_stack = {}

            local function get_cursor_pos0()
                local cur = vim.api.nvim_win_get_cursor(0)
                return cur[1] - 1, cur[2]
            end

            local function node_at_cursor(bufnr)
                local parser = vim.treesitter.get_parser(bufnr)
                local tree = parser:parse()[1]
                if not tree then
                    return nil
                end
                local root = tree:root()
                local row, col = get_cursor_pos0()
                return root:named_descendant_for_range(row, col, row, col)
            end

            local function inclusive_end_pos(end_row, end_col)
                local row = end_row
                local col = end_col - 1
                if col >= 0 then
                    return row, col
                end

                row = end_row - 1
                if row < 0 then
                    return 0, 0
                end

                local last_col = vim.fn.col({ row + 1, "$" }) - 2
                if last_col < 0 then
                    last_col = 0
                end
                return row, last_col
            end

            local function select_node(bufnr, node)
                if not node then
                    return
                end
                local sr, sc, er, ec = node:range()
                local end_row, end_col = inclusive_end_pos(er, ec)
                if end_row < sr or (end_row == sr and end_col < sc) then
                    end_row, end_col = sr, sc
                end

                vim.cmd("normal! \\<Esc>")
                vim.api.nvim_win_set_cursor(0, { sr + 1, sc })
                vim.cmd("normal! v")
                vim.api.nvim_win_set_cursor(0, { end_row + 1, end_col })
            end

            local function current_selected_node(bufnr)
                local stack = selection_stack[bufnr]
                if not stack or #stack == 0 then
                    return nil
                end

                local node = stack[#stack]
                local row, col = get_cursor_pos0()
                if vim.treesitter.is_in_node_range(node, row, col) then
                    return node
                end

                -- Cursor moved: reset selection to the node under cursor.
                local ok, fresh = pcall(node_at_cursor, bufnr)
                if ok and fresh then
                    selection_stack[bufnr] = { fresh }
                    return fresh
                end
                return nil
            end

            local function init_selection()
                local bufnr = vim.api.nvim_get_current_buf()
                local ok, node = pcall(node_at_cursor, bufnr)
                if not ok or not node then
                    return
                end
                selection_stack[bufnr] = { node }
                select_node(bufnr, node)
            end

            local function node_incremental()
                local bufnr = vim.api.nvim_get_current_buf()
                local node = current_selected_node(bufnr)
                if not node then
                    init_selection()
                    node = current_selected_node(bufnr)
                    if not node then
                        return
                    end
                end

                local parent = node:parent()
                while parent and not parent:named() do
                    parent = parent:parent()
                end
                if not parent then
                    return
                end

                selection_stack[bufnr] = selection_stack[bufnr] or {}
                table.insert(selection_stack[bufnr], parent)
                select_node(bufnr, parent)
            end

            local function node_decremental()
                local bufnr = vim.api.nvim_get_current_buf()
                local stack = selection_stack[bufnr]
                if not stack or #stack == 0 then
                    return
                end
                if #stack > 1 then
                    table.remove(stack, #stack)
                end
                select_node(bufnr, stack[#stack])
            end

            local function is_scope_node(query, bufnr, node)
                local sr, _, er, _ = node:range()
                for id, captured in query:iter_captures(node, bufnr, sr, er + 1) do
                    if query.captures[id] == "local.scope" and captured == node then
                        return true
                    end
                end
                return false
            end

            local function scope_incremental()
                local bufnr = vim.api.nvim_get_current_buf()
                local lang = buf_lang(bufnr)
                if not lang then
                    return node_incremental()
                end

                local ok_query, query = pcall(vim.treesitter.query.get, lang, "locals")
                if not ok_query or not query then
                    return node_incremental()
                end

                local node = current_selected_node(bufnr)
                if not node then
                    init_selection()
                    node = current_selected_node(bufnr)
                    if not node then
                        return
                    end
                end

                local scope = node
                while scope and not is_scope_node(query, bufnr, scope) do
                    scope = scope:parent()
                end
                if not scope then
                    return node_incremental()
                end

                local next_scope = scope
                if next_scope == node then
                    next_scope = scope:parent()
                    while next_scope and not is_scope_node(query, bufnr, next_scope) do
                        next_scope = next_scope:parent()
                    end
                end

                if not next_scope then
                    return node_incremental()
                end

                selection_stack[bufnr] = selection_stack[bufnr] or {}
                table.insert(selection_stack[bufnr], next_scope)
                select_node(bufnr, next_scope)
            end

            local treesitter_group = vim.api.nvim_create_augroup("UserTreesitter", { clear = true })
            vim.api.nvim_create_autocmd("FileType", {
                group = treesitter_group,
                pattern = "*",
                callback = function(args)
                    local bufnr = args.buf
                    local buftype = vim.bo[bufnr].buftype
                    local is_normal_buffer = buftype == ""
                    if buftype == "terminal" or buftype == "prompt" then
                        return
                    end

                    local lang = buf_lang(bufnr)
                    if not lang then
                        return
                    end

                    -- Enable Tree-sitter highlighting (Neovim builtin) when available.
                    local ok_start = pcall(vim.treesitter.start, bufnr)
                    if not ok_start and (is_normal_buffer or buftype == "help") then
                        ensure_parser(lang)
                        vim.defer_fn(function()
                            if not pcall(vim.treesitter.start, bufnr) then
                                return
                            end
                            if is_normal_buffer then
                                enable_indentexpr_if_available(bufnr, lang)
                            end
                        end, 1000)
                    end

                    if ok_start and is_normal_buffer then
                        enable_indentexpr_if_available(bufnr, lang)
                    end

                    -- Incremental selection keymaps (buffer-local, as before)
                    if is_normal_buffer then
                        vim.keymap.set("n", "gnn", init_selection, { buffer = bufnr, desc = "TS: Init selection" })
                        vim.keymap.set({ "n", "x" }, "grn", node_incremental, { buffer = bufnr, desc = "TS: Node +" })
                        vim.keymap.set({ "n", "x" }, "grm", node_decremental, { buffer = bufnr, desc = "TS: Node -" })
                        vim.keymap.set({ "n", "x" }, "grc", scope_incremental, { buffer = bufnr, desc = "TS: Scope +" })
                    end
                end,
            })

            vim.keymap.set("n", "<leader>vs", function()
                init_selection()
                scope_incremental()
            end, { desc = "Select entire scope" })

            vim.keymap.set("n", "<F12>", function()
                vim.cmd("Inspect")
            end, { desc = "Inspect highlights/TreeSitter at cursor" })

            -- Tree-sitter folds: set globally (not just current window)
            vim.opt.foldmethod = "expr"
            vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
            vim.opt.foldenable = true
            vim.opt.foldlevel = 99
            vim.opt.foldlevelstart = 99
        end,
    },

    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        branch = "main",
        lazy = false,
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        config = function()
            require("nvim-treesitter-textobjects").setup({
                select = {
                    lookahead = true,
                },
            })

            local select = require("nvim-treesitter-textobjects.select")

            vim.keymap.set({ "x", "o" }, "af", function()
                select.select_textobject("@function.outer", "textobjects")
            end, { desc = "Textobject: Function (outer)" })

            vim.keymap.set({ "x", "o" }, "if", function()
                select.select_textobject("@function.inner", "textobjects")
            end, { desc = "Textobject: Function (inner)" })

            vim.keymap.set({ "x", "o" }, "ac", function()
                select.select_textobject("@class.outer", "textobjects")
            end, { desc = "Textobject: Class (outer)" })

            vim.keymap.set({ "x", "o" }, "ic", function()
                select.select_textobject("@class.inner", "textobjects")
            end, { desc = "Textobject: Class (inner)" })
        end,
    },

    {
        "nvim-treesitter/nvim-treesitter-context",
        lazy = false,
        opts = { enable = true, max_lines = 3 },
    },
}

