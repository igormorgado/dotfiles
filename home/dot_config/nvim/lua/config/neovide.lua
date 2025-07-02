-- Neovide GUI-specific settings
local M = {}

function M.setup()
    if not vim.g.neovide then
        return
    end

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

return M