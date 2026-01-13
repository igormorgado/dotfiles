local languages = {
  "python", "c", "vim", "javascript", "sql", "vimdoc",
  "html", "query", "css", "lua", "markdown", "markdown_inline",
  "json", "yaml",
  -- NOTE: jsonc is tricky on some networks (GitLab 403); add later if needed.
}

return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false, -- required: main rewrite does not support lazy-loading
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").setup({
        -- keep your custom install dir if you want
        install_dir = vim.fn.stdpath("data") .. "/treesitter",
      })

      -- Keep folds open by default (method is set per-buffer by treesitter-modules)
      vim.opt.foldlevel = 99
      vim.opt.foldlevelstart = 99
      vim.opt.foldenable = true

      -- OPTIONAL: if you later decide to install jsonc and GitLab blocks you,
      -- we can override the parser URL to a GitHub fork.
      -- (We’ll only enable this if you actually need jsonc.)
    end,
  },

  {
    "MeanderingProgrammer/treesitter-modules.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {
      ensure_installed = languages,
      auto_install = true,

      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },

      indent = { enable = true },

      fold = { enable = true },

      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "gnn",
          node_incremental = "grn",
          scope_incremental = "grc",
          node_decremental = "grm",
        },
      },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("nvim-treesitter-textobjects").setup({
        select = { lookahead = true },
      })

      local sel = require("nvim-treesitter-textobjects.select")
      vim.keymap.set({ "x", "o" }, "af", function()
        sel.select_textobject("@function.outer", "textobjects")
      end)
      vim.keymap.set({ "x", "o" }, "if", function()
        sel.select_textobject("@function.inner", "textobjects")
      end)
      vim.keymap.set({ "x", "o" }, "ac", function()
        sel.select_textobject("@class.outer", "textobjects")
      end)
      vim.keymap.set({ "x", "o" }, "ic", function()
        sel.select_textobject("@class.inner", "textobjects")
      end)
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter-context",
    opts = { enable = true, max_lines = 3 },
  },
}

