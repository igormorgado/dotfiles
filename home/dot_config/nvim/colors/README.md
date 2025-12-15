# DarkTrial Colorscheme

A dark theme for boring people, now available in both Vim and Lua versions.

## Features

- **Dual Format**: Available in both traditional Vim script (`darktrial.vim`) and modern Lua (`darktrial.lua`)
- **Extensive Language Support**: Comprehensive TreeSitter and LSP integration
- **Plugin Integration**: Built-in support for popular Neovim plugins
- **Customizable**: Configurable options while maintaining defaults
- **Performance**: Lua version offers better performance and lazy loading
- **Accessibility**: Thoughtful color choices for readability

## Installation

### Using Lazy.nvim

```lua
{
  dir = "/Users/igormorgado/.config/nvim/colors",
  name = "darktrial",
  priority = 1000,
  config = function()
    -- Basic usage (uses all defaults)
    vim.cmd('colorscheme darktrial')
    
    -- Or with custom configuration
    require('darktrial').setup({
      transparent_background = false,
      italic_comments = true,
      bold_keywords = true,
    })
    vim.cmd('colorscheme darktrial')
  end,
}
```

### Manual Installation

1. Copy files to your Neovim colors directory
2. Add to your `init.lua`:

```lua
-- For Lua version (recommended)
require('darktrial').setup()
vim.cmd('colorscheme darktrial')

-- Or for Vim version
vim.cmd('colorscheme darktrial')
```

## Configuration

The Lua version supports extensive customization while maintaining backward compatibility:

```lua
require('darktrial').setup({
  -- Background and styling
  transparent_background = false,  -- Enable transparent background
  italic_comments = true,          -- Use italic for comments
  italic_constants = true,         -- Use italic for constants
  bold_keywords = true,            -- Use bold for keywords/statements
  bold_special = true,             -- Use bold for special elements
  
  -- Modern features
  enable_treesitter = true,        -- Enable TreeSitter highlights
  enable_lsp = true,               -- Enable LSP highlights
  enable_diagnostics = true,       -- Enable diagnostic highlights
  
  -- Plugin integrations (auto-detected)
  plugin_integrations = {
    indent_blankline = true,       -- Enable indent-blankline highlights
    nvim_cmp = true,               -- Enable nvim-cmp highlights
    gitsigns = true,               -- Enable gitsigns highlights
    telescope = true,              -- Enable telescope highlights
    nvim_tree = true,              -- Enable nvim-tree highlights
    which_key = true,              -- Enable which-key highlights
  },
})
```

## Supported Languages

The TreeSitter integration provides highlighting for:

- **Programming Languages**: Lua, Python, JavaScript, TypeScript, Rust, Go, C/C++, Java, etc.
- **Markup Languages**: Markdown, HTML, XML, LaTeX
- **Configuration**: JSON, YAML, TOML, INI
- **And many more...**

## Plugin Support

Built-in integration for popular plugins:

- **nvim-treesitter**: Comprehensive syntax highlighting
- **nvim-lsp**: LSP reference and diagnostic highlighting
- **nvim-cmp**: Completion menu theming
- **indent-blankline.nvim**: Indent guide styling
- **gitsigns.nvim**: Git change indicators
- **telescope.nvim**: Fuzzy finder theming
- **nvim-tree.lua**: File explorer theming
- **which-key.nvim**: Keybinding helper theming

## Color Palette

The theme uses a carefully selected dark palette:

- **Background**: `#121212` (Rich black)
- **Foreground**: `#eeeeee` (Soft white)
- **Accent**: `#84a7f2` (Calm blue)
- **Success**: `#48d56b` (Fresh green)
- **Warning**: `#f2d085` (Warm yellow)
- **Error**: `#ff7c3b` (Vibrant orange)
- **Info**: `#84a7f2` (Calm blue)
- **Hint**: `#39e7d8` (Cool cyan)

## Differences Between Versions

### Vim Version (`darktrial.vim`)
- Traditional Vim script format
- Compatible with both Vim and Neovim
- Supports terminal colors and basic highlights
- Uses `g:darktrial_transp_bg` for transparency

### Lua Version (`darktrial.lua`)
- Modern Neovim-specific implementation
- Better performance and lazy loading
- Extensive TreeSitter and LSP support
- Rich plugin integrations
- Configurable options
- Color utilities for manipulation

## Migration from Vim to Lua

If you're currently using the Vim version, migration is simple:

```lua
-- Before (Vim version)
vim.g.darktrial_transp_bg = 1
vim.cmd('colorscheme darktrial')

-- After (Lua version)
require('darktrial').setup({
  transparent_background = true,
})
vim.cmd('colorscheme darktrial')
```

## Advanced Usage

### Accessing Colors Programmatically

```lua
local darktrial = require('darktrial')
local colors = darktrial.get_colors()

-- Use colors in your own highlights
vim.api.nvim_set_hl(0, 'MyCustomGroup', {
  fg = colors.accent,
  bg = colors.bg_secondary,
  bold = true
})
```

### Custom Plugin Integration

```lua
local darktrial = require('darktrial')
local colors = darktrial.get_colors()

-- Add custom plugin highlights
vim.api.nvim_set_hl(0, 'MyPluginHighlight', {
  fg = colors.success,
  bg = colors.bg_primary
})
```

## Contributing

Feel free to submit issues or pull requests to improve the theme.

## License

Public domain - use freely in any project.