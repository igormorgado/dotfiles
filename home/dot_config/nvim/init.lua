-- Modular Neovim Configuration
-- Main entry point that loads all configuration modules

-- Performance: Enable bytecode cache (Neovim 0.9+)
if vim.loader then
    vim.loader.enable()
end

-- Load core configuration modules
require('config.options').setup()
require('config.persistence').setup()
require('config.commands').setup()
require('config.autocmds').setup()
require('config.keymaps').setup()
require('config.neovide').setup()

-- Plugin manager setup (Lazy.nvim)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.runtimepath:prepend(lazypath)

-- Load all plugin configurations
require("lazy").setup({
    -- Import all plugin modules
    { import = "plugins.ui" },
    { import = "plugins.editor" },
    { import = "plugins.git" },
    { import = "plugins.lsp" },
    { import = "plugins.linting" },
    { import = "plugins.fuzzy" },
    { import = "plugins.treesitter" },
    { import = "plugins.ai" },
    { import = "plugins.lang" },
}, {
    -- Lazy.nvim configuration
    defaults = {
        -- lazy = false,      -- Always load plugins immediately unless explicitly marked
        -- version = false,   -- Always use the latest version
    },
    dev = {
        -- path = "~/projects",   -- For local development
        -- fallback = true,       -- Try loading from git if local dev not found
    },
    install = {
        missing = true,  -- Install missing plugins on startup
        -- colorscheme = { "habamax" },
    },
    checker = {
        enabled = true,
        notify = false,
    },
    change_detection = {
        enabled = true,
        notify = false,
    },

    -- Disable LuaRocks integration
    rocks = {
        enabled = false,       -- disable LuaRocks support completely
        hererocks = false,     -- disable hererocks entirely
    },

    -- Performance optimizations
    performance = {
        cache = {
            enabled = true,
        },
        reset_packpath = true, -- reset the package path to improve startup time
        rtp = {
            reset = true, -- reset the runtime path to $VIMRUNTIME and your config directory
            paths = {}, -- add any custom paths here that you want to include in the rtp
            disabled_plugins = {
                "gzip",
                "matchparen",
                "netrwPlugin",
                "tarPlugin",
                "tohtml",
                "tutor",
                "zipPlugin",
            },
        },
    },
})
