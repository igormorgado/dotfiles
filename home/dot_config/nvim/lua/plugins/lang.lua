-- Language-specific plugins
return {
    -- Python
    {
        "geg2102/nvim-python-repl",
        dependencies = "nvim-treesitter",
        ft = { "python" },
        config = function()
            local repl = require("nvim-python-repl")
            repl.setup({
                execute_on_send = true,
                vsplit = false,
            })
            local function call(method)
                return function() repl[method]() end
            end

            local function send_and_jump()
                repl.send_statement_definition()
                vim.cmd('normal! ]]')
            end
             -- declarative map table: mode -> { lhs = {method, desc} }
            local maps = {
              n = {
                ["<leader>ee"] = { "send_statement_definition", "Execute: Send semantic unit to REPL" },
                ["<leader>ej"] = { send_and_jump,              "Execute: Send semantic unit and jump to next" },
                ["<leader>eb"] = { "send_buffer_to_repl",       "Execute: Send entire buffer to REPL" },
                ["<leader>ct"] = { "toggle_execute",            "Code: Toggle auto-execute in REPL" },
                ["<leader>lv"] = { "toggle_vertical",           "Language: Toggle REPL vertical/horizontal split" },
                ["<leader>ls"] = { "open_repl",                 "Language: Open REPL in window split" },
              },
              x = {
                ["<leader>ee"] = { "send_visual_to_repl",       "Execute: Send visual selection to REPL" },
              },
            }

            for mode, defs in pairs(maps) do
              for lhs, spec in pairs(defs) do
                local handler = type(spec[1]) == "function" and spec[1] or call(spec[1])
                vim.keymap.set(mode, lhs, handler, { desc = spec[2] })
              end
            end
        end
    },

    -- LaTeX
    {
        'lervag/vimtex',
        ft = { 'tex', 'latex' },
        init = function()
            vim.g.vimtex_compiler_method = 'latexmk'
            vim.g.vimtex_view_method = 'zathura'
            vim.keymap.set('n', '<localleader>lv', '<plug>(vimtex-view)', { desc='Language: View PDF' })
            vim.keymap.set('n', '<localleader>lt', '<cmd>VimtexTocToggle<cr>', { desc='Language: Toggle VimTeX ToC' })
        end,
    },

    -- Markdown
    {
        'preservim/vim-markdown',
        dependencies = { 'godlygeek/tabular' },
        ft = 'markdown'
    },
}
