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

    -- Darktrial commands
    local function get_darktrial()
        local darktrial = package.loaded['darktrial']
        if not darktrial then
            vim.cmd('colorscheme darktrial')
            darktrial = package.loaded['darktrial']
        end
        if not darktrial then
            vim.notify("Failed to load darktrial colorscheme", vim.log.levels.ERROR)
        end
        return darktrial
    end

    -- Toggle boring mode
    vim.api.nvim_create_user_command('DarktrialToggleBoring', function()
        local darktrial = get_darktrial()
        if darktrial then darktrial.toggle_boring() end
    end, { desc = 'Toggle DarkTrial boring (monochrome) mode' })

    -- Toggle transparent background
    vim.api.nvim_create_user_command('DarktrialToggleTransparent', function()
        local darktrial = get_darktrial()
        if darktrial then darktrial.toggle_transparent() end
    end, { desc = 'Toggle DarkTrial transparent background' })

    -- Toggle dim inactive windows
    vim.api.nvim_create_user_command('DarktrialToggleDimInactive', function()
        local darktrial = get_darktrial()
        if darktrial then darktrial.toggle_dim_inactive() end
    end, { desc = 'Toggle DarkTrial dim inactive windows' })

    -- Cycle contrast levels
    vim.api.nvim_create_user_command('DarktrialCycleContrast', function()
        local darktrial = get_darktrial()
        if darktrial then darktrial.cycle_contrast() end
    end, { desc = 'Cycle DarkTrial contrast levels (low/medium/high)' })

    -- Check contrast ratio
    vim.api.nvim_create_user_command('DarktrialCheckContrast', function()
        local darktrial = get_darktrial()
        if darktrial then darktrial.check_contrast() end
    end, { desc = 'Check DarkTrial WCAG contrast ratio' })

    -- Show help
    vim.api.nvim_create_user_command('DarktrialHelp', function()
        local darktrial = get_darktrial()
        if darktrial then darktrial.help() end
    end, { desc = 'Show DarkTrial colorscheme help' })

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
