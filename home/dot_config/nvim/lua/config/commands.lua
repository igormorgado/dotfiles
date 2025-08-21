-- Custom commands and utility functions
local M = {}

function M.setup()
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

    -- Treesitter syntax inspection
    function _G.ts_syntax_at_point()
        local bufnr = vim.api.nvim_get_current_buf()
        local cursor = vim.api.nvim_win_get_cursor(0)
        local row, col = cursor[1] - 1, cursor[2]
        
        local parsers = require('nvim-treesitter.parsers')
        if not parsers.has_parser() then
            print("No treesitter parser available for this buffer")
            return
        end
        
        local parser = vim.treesitter.get_parser(bufnr)
        local tree = parser:parse()[1]
        local root = tree:root()
        
        local node = root:named_descendant_for_range(row, col, row, col)
        
        if node then
            local node_type = node:type()
            print("Treesitter node: " .. node_type)
            
            local ts_utils = require('nvim-treesitter.ts_utils')
            local hl_groups = vim.treesitter.highlighter.hl_map
            if hl_groups then
                print("Highlight group: " .. vim.inspect(hl_groups[node_type] or "unknown"))
            end
        else
            print("No treesitter node at cursor position")
        end
    end

    vim.keymap.set('n', '<F12>', _G.ts_syntax_at_point, {noremap = true})

    -- Typewriter mode toggle
    vim.g.typewriter_mode = false
    vim.g.typewriter_saved = {}

    function _G.toggle_typewriter()
        if not vim.g.typewriter_mode then
            vim.g.typewriter_saved.scrolloff = vim.wo.scrolloff
            vim.g.typewriter_saved.sidescrolloff = vim.wo.sidescrolloff

            local h = vim.api.nvim_win_get_height(0)
            local half = math.floor(h / 2)

            vim.wo.scrolloff = half
            vim.wo.sidescrolloff = 0
            vim.g.typewriter_mode = true
            vim.notify("Typewriter mode ON (cursor stays centered)", vim.log.levels.INFO)
        else
            vim.wo.scrolloff = vim.g.typewriter_saved.scrolloff
            vim.wo.sidescrolloff = vim.g.typewriter_saved.sidescrolloff
            vim.g.typewriter_mode = false
            vim.notify("Typewriter mode OFF", vim.log.levels.INFO)
        end
    end

    vim.keymap.set("n", "<localleader>tw", _G.toggle_typewriter, { 
        noremap = true, 
        silent = true, 
        desc = "Toggle typewriter scroll mode" 
    })

    -- Function to apply custom colored columns
    function _G.set_colored_columns()
      -- Skip if this is a Claude Code window
      if vim.bo.filetype == 'claude-code' or string.find(vim.api.nvim_buf_get_name(0), 'claude') then
        return
      end
      
      -- Skip terminal buffers
      if vim.bo.buftype == 'terminal' then
        return
      end
      
      -- Also check if buffer name contains 'term://'
      local bufname = vim.api.nvim_buf_get_name(0)
      if string.match(bufname, '^term://') then
        return
      end
      
      -- Remove existing matches to avoid duplicates
      if vim.w.colored_column_matches then
        for _, match in ipairs(vim.w.colored_column_matches) do
          vim.fn.matchdelete(match)
        end
      end
    
      -- Add new matches at specified columns
      vim.w.colored_column_matches = {
        vim.fn.matchadd('ColorColumn80', '\\%80v.', 100),
        vim.fn.matchadd('ColorColumn120', '\\%120v.', 100),
      }
    end

    function _G.safe_set_colorcolumn_hl(name, link)
        local existing = vim.api.nvim_get_hl(0, { name = name, link = true })
        if not existing.link then
            vim.api.nvim_set_hl(0, name, { link = link })
        end
    end

    -- Set up custom highlight groups linked to existing colorscheme highlights
    safe_set_colorcolumn_hl('ColorColumn80', 'WarningMsg')
    safe_set_colorcolumn_hl('ColorColumn120', 'ErrorMsg')

end

return M
