-- UI and appearance plugins
return {
    {
        'nvim-lualine/lualine.nvim',
        event = "VeryLazy",
        config = function()
            vim.opt.showmode = false
            
            local function dynamic_path()
                local cwd = vim.fn.getcwd()
                local full_path = vim.fn.expand('%:p')
                local relative_path = vim.fn.fnamemodify(full_path, ':~:.')
                local short_path = vim.fn.pathshorten(relative_path)
                local filename = vim.fn.fnamemodify(full_path, ':t')
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
                if #clients == 0 then
                    return ''
                end
                local client_names = {}
                for _, client in ipairs(clients) do
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
        build = "make hexokinase",
        config = function()
            vim.g.Hexokinase_highlighters = { "virtual" }
            vim.g.Hexokinase_ftOptInPatterns = {
                fish = "full_hex,rgb,colour_names"
            }
            vim.cmd("HexokinaseTurnOn")
        end,
    },

    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {},
        config = function()
            require("ibl").setup {
                scope = { enabled = true },
            }
        end
    },

    {
        "lifepillar/vim-colortemplate", 
        lazy = false 
    },
}