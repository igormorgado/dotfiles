-- UI and appearance plugins
return {
    {
        "knubie/vim-kitty-navigator",
        build = "cp ./*.py ~/.config/kitty/",
    },

    {
        "alexghergh/nvim-tmux-navigation",
        config = function()
            require("nvim-tmux-navigation").setup({
                keybindings = {
                    left = "<C-h>",
                    down = "<C-j>",
                    up = "<C-k>",
                    right = "<C-l>",
                    last_active = "<C-\\>",
                    next = "<C-Space>",
                }
            })
        end,
    },

    {
        'akinsho/bufferline.nvim',
        version = "*",
        dependencies = 'nvim-tree/nvim-web-devicons',
        event = "VeryLazy",
        keys = {
            { "<leader>bp", "<cmd>BufferLineTogglePin<CR>", desc = "Buffer: Toggle pin" },
            { "<leader>bP", "<cmd>BufferLineGroupClose ungrouped<CR>", desc = "Buffer: Delete non-pinned buffers" },
            { "<leader>bo", "<cmd>BufferLineCloseOthers<CR>", desc = "Buffer: Delete others" },
            { "<leader>br", "<cmd>BufferLineCloseRight<CR>", desc = "Buffer: Delete to the right" },
            { "<leader>bl", "<cmd>BufferLineCloseLeft<CR>", desc = "Buffer: Delete to the left" },
            { "[b", "<cmd>BufferLineCyclePrev<CR>", desc = "Prev buffer" },
            { "]b", "<cmd>BufferLineCycleNext<CR>", desc = "Next buffer" },
        },
        config = function()
            require("bufferline").setup({
                options = {
                    close_command = "bdelete! %d",
                    right_mouse_command = "bdelete! %d",
                    left_mouse_command = "buffer %d",
                    middle_mouse_command = nil,
                    indicator = {
                        icon = "▎",
                        style = "icon",
                    },
                    buffer_close_icon = "󰅖",
                    modified_icon = "●",
                    close_icon = "",
                    left_trunc_marker = "",
                    right_trunc_marker = "",
                    max_name_length = 30,
                    max_prefix_length = 30,
                    tab_size = 21,
                    diagnostics = "nvim_lsp",
                    diagnostics_update_in_insert = false,
                    color_icons = true,
                    show_buffer_icons = true,
                    show_buffer_close_icons = true,
                    show_close_icon = true,
                    show_tab_indicators = true,
                    persist_buffer_sort = true,
                    separator_style = "slant",
                    enforce_regular_tabs = true,
                    always_show_bufferline = true,
                    offsets = {
                        {
                            filetype = "NvimTree",
                            text = "File Explorer",
                            text_align = "left",
                            separator = true,
                        }
                    },
                },
            })
        end,
    },

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
            -- Let the colorscheme handle the highlights
            require("ibl").setup {
                scope = {
                    enabled = true,
                    highlight = "IblScope",
                    show_start = true,
                    show_end = false,
                    include = {
                        node_type = {
                            python = {
                                "function_definition",
                                "class_definition",
                                "with_statement",
                                "for_statement",
                                "while_statement",
                                "if_statement",
                                "try_statement",
                            },
                        },
                    },
                },
                indent = {
                    highlight = "IblIndent",
                    char = "│",
                },
                whitespace = {
                    highlight = "IblWhitespace",
                },
            }
        end
    },

    {
        "lifepillar/vim-colortemplate",
        lazy = false
    },

    -- Add mini.icons for which-key compatibility
    {
        "echasnovski/mini.icons",
        version = false,
        config = function()
            require('mini.icons').setup()
        end
    },
}
