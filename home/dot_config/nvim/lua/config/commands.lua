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

    -- Darktrial boring mode toggle
    vim.api.nvim_create_user_command('DarktrialToggleBoring', function()
        -- Load the colorscheme module properly from package cache
        local darktrial = package.loaded['darktrial']

        if not darktrial then
            -- If not loaded yet, source the colorscheme file
            vim.cmd('colorscheme darktrial')
            darktrial = package.loaded['darktrial']
        end

        if darktrial then
            -- Toggle boring mode (includes indent-blankline refresh)
            darktrial.toggle_boring()
        else
            vim.notify("Failed to load darktrial colorscheme", vim.log.levels.ERROR)
        end
    end, {})

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
