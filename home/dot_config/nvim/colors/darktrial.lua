-- Name:         DarkTrial
-- Description:  A dark theme for boring people
-- Author:       Igor Morgado <morgado.igor@gmail.com>
-- Maintainer:   Igor Morgado <morgado.igor@gmail.com>
-- Website:      https://www.fer.mat
-- License:      Public domain
-- Last Change:  2025 Dec 15
--
-- Usage:
--   -- Basic usage (keeps all defaults)
--   vim.cmd('colorscheme darktrial')
--
--   -- With custom options
--   require('darktrial').setup({
--     transparent_background = true,
--     italic_comments = false,
--     bold_keywords = false,
--     boring = true,  -- Use monochromatic syntax
--   })
--   vim.cmd('colorscheme darktrial')
--
--   -- Toggle boring mode at runtime
--   :lua require('darktrial').toggle_boring()

local M = {}

-- Default configuration
local default_config = {
  transparent_background = false,  -- Enable transparent background
  italic_comments = true,          -- Use italic for comments
  italic_constants = true,         -- Use italic for constants
  bold_keywords = true,           -- Use bold for keywords/statements
  bold_special = true,            -- Use bold for special elements
  boring = false,                 -- Use monochromatic syntax (no colors for strings, keywords, special)
  enable_treesitter = true,       -- Enable TreeSitter highlights
  enable_lsp = true,              -- Enable LSP highlights
  enable_diagnostics = true,      -- Enable diagnostic highlights
  plugin_integrations = {
    indent_blankline = true,      -- Enable indent-blankline highlights
    nvim_cmp = true,              -- Enable nvim-cmp highlights
    gitsigns = true,              -- Enable gitsigns highlights
    telescope = true,             -- Enable telescope highlights
    nvim_tree = true,             -- Enable nvim-tree highlights
    which_key = true,             -- Enable which-key highlights
  },
}

-- User configuration (will be merged with defaults)
local config = {}

-- Raw color palette
local raw_colors = {
  black         = "#121212",
  red           = "#ff7c3b",
  green         = "#48d56b",
  yellow        = "#f2d085",
  blue          = "#84a7f2",
  magenta       = "#ff66e4",
  cyan          = "#39e7d8",
  white         = "#eeeeee",
  brightblack   = "#4e4e4e",
  brightred     = "#b51530",
  brightgreen   = "#076b47",
  brightyellow  = "#934305",
  brightblue    = "#10237a",
  brightmagenta = "#9700b7",
  brightcyan    = "#005c7d",
  brightwhite   = "#b2b2b2",
  highcol       = "#303030",
}

-- Color utilities
local utils = {}

-- Convert hex to RGB
utils.hex_to_rgb = function(hex)
  hex = hex:gsub("#", "")
  return {
    r = tonumber(hex:sub(1, 2), 16),
    g = tonumber(hex:sub(3, 4), 16),
    b = tonumber(hex:sub(5, 6), 16),
  }
end

-- Convert RGB to hex
utils.rgb_to_hex = function(r, g, b)
  return string.format("#%02x%02x%02x", r, g, b)
end

-- Darken a color by a percentage
utils.darken = function(color, percentage)
  local rgb = utils.hex_to_rgb(color)
  local factor = 1 - (percentage / 100)
  return utils.rgb_to_hex(
    math.floor(rgb.r * factor),
    math.floor(rgb.g * factor),
    math.floor(rgb.b * factor)
  )
end

-- Lighten a color by a percentage
utils.lighten = function(color, percentage)
  local rgb = utils.hex_to_rgb(color)
  local factor = percentage / 100
  return utils.rgb_to_hex(
    math.min(255, math.floor(rgb.r + (255 - rgb.r) * factor)),
    math.min(255, math.floor(rgb.g + (255 - rgb.g) * factor)),
    math.min(255, math.floor(rgb.b + (255 - rgb.b) * factor))
  )
end

-- Blend two colors
utils.blend = function(color1, color2, ratio)
  local rgb1 = utils.hex_to_rgb(color1)
  local rgb2 = utils.hex_to_rgb(color2)
  return utils.rgb_to_hex(
    math.floor(rgb1.r * (1 - ratio) + rgb2.r * ratio),
    math.floor(rgb1.g * (1 - ratio) + rgb2.g * ratio),
    math.floor(rgb1.b * (1 - ratio) + rgb2.b * ratio)
  )
end

-- Semantic color names based on raw colors
local function get_colors()
  local background = config.transparent_background and "NONE" or raw_colors.black
  
  return {
    -- Background colors
    bg_primary = background,
    bg_secondary = raw_colors.highcol,
    bg_accent = raw_colors.brightblack,
    bg_float = raw_colors.brightblack,
    
    -- Foreground colors
    fg_primary = raw_colors.white,
    fg_secondary = raw_colors.brightwhite,
    fg_muted = raw_colors.brightblack,
    
    -- Accent colors
    accent = raw_colors.blue,
    accent_secondary = raw_colors.cyan,
    
    -- Semantic colors
    success = raw_colors.green,
    warning = raw_colors.yellow,
    error = raw_colors.red,
    info = raw_colors.blue,
    hint = raw_colors.cyan,
    
    -- Diff colors
    diff_add = raw_colors.green,
    diff_change = raw_colors.cyan,
    diff_delete = raw_colors.red,
    diff_text = raw_colors.magenta,
    
    -- Git colors
    git_add = raw_colors.green,
    git_change = raw_colors.yellow,
    git_delete = raw_colors.red,
    
    -- Syntax colors
    comment = raw_colors.brightwhite,
    constant = raw_colors.white,
    string = config.boring and raw_colors.white or raw_colors.green,
    identifier = raw_colors.blue,
    statement = config.boring and raw_colors.white or raw_colors.yellow,
    preproc = raw_colors.white,
    type = raw_colors.brightwhite,
    special = config.boring and raw_colors.white or raw_colors.magenta,
    
    -- Raw colors (for compatibility)
    black = raw_colors.black,
    red = raw_colors.red,
    green = raw_colors.green,
    yellow = raw_colors.yellow,
    blue = raw_colors.blue,
    magenta = raw_colors.magenta,
    cyan = raw_colors.cyan,
    white = raw_colors.white,
    brightblack = raw_colors.brightblack,
    brightred = raw_colors.brightred,
    brightgreen = raw_colors.brightgreen,
    brightyellow = raw_colors.brightyellow,
    brightblue = raw_colors.brightblue,
    brightmagenta = raw_colors.brightmagenta,
    brightcyan = raw_colors.brightcyan,
    brightwhite = raw_colors.brightwhite,
  }
end

-- Helper function to set highlight groups
local function hl(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

-- Helper function for links
local function link(from, to)
  vim.api.nvim_set_hl(0, from, { link = to })
end

-- Check if a plugin is loaded
local function plugin_loaded(plugin)
  return vim.fn.exists('g:loaded_' .. plugin) == 1 or 
         pcall(require, plugin) or
         vim.fn.isdirectory(vim.fn.stdpath('data') .. '/lazy/' .. plugin) == 1
end

-- Setup function with user configuration
function M.setup(user_config)
  -- Merge user config with defaults
  config = vim.tbl_deep_extend('force', default_config, user_config or {})
  
  -- Apply the colorscheme
  M.load()
end

-- Main colorscheme loading function
function M.load()
  -- Reset colors
  vim.cmd("hi clear")
  if vim.fn.exists("syntax_on") then
    vim.cmd("syntax reset")
  end
  
  vim.g.colors_name = "darktrial"
  vim.o.background = "dark"
  
  -- Get the color palette
  local colors = get_colors()
  
  -- Check for italic support
  local has_italics = vim.fn.has('gui_running') == 1 or 
                     (vim.env.TERM and (vim.env.TERM:match('xterm') or vim.env.TERM:match('screen') or vim.env.TERM:match('tmux')))
  
  -- Override italic support based on config
  if not config.italic_comments then has_italics = false end
  
  -- Terminal colors
  vim.g.terminal_ansi_colors = {
    colors.black,
    colors.red,
    colors.green,
    colors.yellow,
    colors.blue,
    colors.magenta,
    colors.cyan,
    colors.white,
    colors.brightblack,
    colors.brightred,
    colors.brightgreen,
    colors.brightyellow,
    colors.brightblue,
    colors.brightmagenta,
    colors.brightcyan,
    colors.brightwhite,
  }
  
  -- Editor highlights
  hl("Normal", { fg = colors.fg_primary, bg = colors.bg_primary })
  hl("Terminal", { fg = colors.fg_primary, bg = colors.bg_primary })
  hl("ColorColumn", { bg = colors.bg_secondary })
  hl("Conceal", {})
  hl("Cursor", {})
  hl("CursorColumn", { bg = colors.bg_secondary })
  hl("CursorLine", { bg = colors.bg_secondary })
  hl("CursorLineNr", { fg = colors.fg_primary, bold = true })
  hl("DiffAdd", { fg = colors.diff_add, reverse = true })
  hl("DiffChange", { fg = colors.diff_change, reverse = true })
  hl("DiffDelete", { fg = colors.diff_delete, reverse = true })
  hl("DiffText", { fg = colors.diff_text, bold = true, reverse = true })
  hl("Directory", { fg = colors.accent })
  hl("EndOfBuffer", {})
  hl("ErrorMsg", { fg = colors.error, bg = colors.bg_primary, reverse = true })
  hl("FoldColumn", { fg = colors.fg_muted, bg = colors.bg_primary })
  hl("Folded", { fg = colors.fg_secondary, bg = colors.bg_accent, italic = has_italics and config.italic_comments })
  hl("IncSearch", { fg = colors.fg_primary, bg = colors.bg_primary, standout = true })
  hl("LineNr", { fg = colors.fg_muted, bg = colors.bg_primary })
  hl("MatchParen", { fg = colors.bg_primary, bg = colors.warning })
  hl("ModeMsg", { fg = colors.bg_primary, bg = colors.success, bold = true })
  hl("MoreMsg", { fg = colors.bg_primary, bg = colors.accent, bold = true })
  hl("NonText", { fg = colors.fg_secondary })
  hl("Pmenu", { fg = colors.bg_primary, bg = colors.fg_secondary })
  hl("PmenuSbar", { fg = colors.bg_primary, bg = colors.fg_primary })
  hl("PmenuSel", { reverse = true })
  hl("PmenuThumb", { bg = colors.accent })
  hl("Question", { fg = colors.bg_primary, bg = colors.success })
  hl("Search", { fg = colors.fg_primary, bg = colors.bg_primary, bold = true, reverse = true })
  hl("SignColumn", { fg = colors.fg_muted, bg = colors.bg_primary })
  hl("SpecialKey", { fg = colors.fg_secondary })
  hl("SpellBad", { bg = colors.brightred, sp = colors.brightred })
  hl("SpellCap", { bg = colors.accent, sp = colors.brightblue })
  hl("SpellLocal", { bg = colors.magenta, sp = colors.brightmagenta })
  hl("SpellRare", { bg = colors.brightcyan, sp = colors.brightcyan })
  hl("StatusLine", { bg = colors.accent, bold = true })
  hl("StatusLineNC", { bg = colors.bg_accent })
  hl("TabLine", { bg = colors.bg_accent, bold = true })
  hl("TabLineFill", {})
  hl("TabLineSel", { fg = colors.fg_primary, bg = colors.accent, bold = true })
  hl("Title", { fg = colors.fg_muted, bg = colors.accent })
  hl("VertSplit", { fg = colors.accent, bg = colors.bg_primary, bold = true })
  hl("Visual", { reverse = true })
  hl("VisualNOS", { fg = colors.fg_primary, bg = colors.bg_primary })
  hl("WarningMsg", { fg = colors.bg_primary, bg = colors.warning })
  hl("WildMenu", { fg = colors.fg_primary, bg = colors.bg_primary })
  
  -- Syntax highlights
  hl("Comment", { fg = colors.comment, italic = has_italics and config.italic_comments })
  hl("Constant", { fg = colors.constant, italic = has_italics and config.italic_constants })
  hl("Error", { fg = colors.fg_primary, bg = colors.error, reverse = true })
  hl("Identifier", { fg = colors.identifier })
  hl("Ignore", { fg = colors.success })
  hl("PreProc", { fg = colors.preproc })
  hl("Special", { fg = colors.special, bold = config.bold_special })
  hl("Statement", { fg = colors.statement, bold = config.bold_keywords })
  hl("Todo", { fg = colors.warning, bold = true, reverse = true })
  hl("Type", { fg = colors.type })
  hl("Underlined", { fg = colors.fg_primary, underline = true })
  hl("CursorIM", { bg = "fg" })
  hl("ToolbarLine", { bg = colors.fg_secondary })
  hl("ToolbarButton", { fg = colors.fg_primary, bg = colors.bg_accent, bold = true })
  
  -- TreeSitter highlights (when enabled)
  if config.enable_treesitter then
    M.set_treesitter_highlights(colors)
  end
  
  -- LSP and diagnostic highlights (when enabled)
  if config.enable_lsp then
    M.set_lsp_highlights(colors)
  end
  
  if config.enable_diagnostics then
    M.set_diagnostic_highlights(colors)
  end
  
  -- Float windows
  hl("NormalFloat", { fg = colors.accent, bg = colors.bg_float })
  hl("FloatBorder", { fg = colors.accent, bg = colors.bg_primary })
  hl("FloatTitle", { fg = colors.fg_primary, bg = colors.accent, bold = true })
  
  -- Plugin-specific highlights (lazy loaded)
  M.set_plugin_highlights(colors)
  
  -- Links
  link("Added", "diffAdded")
  link("Boolean", "Constant")
  link("Character", "Constant")
  link("Changed", "diffChanged")
  link("Conditional", "Statement")
  link("CurSearch", "IncSearch")
  link("CursorLineFold", "FoldColumn")
  link("CursorLineSign", "SignColumn")
  link("Debug", "Special")
  link("Define", "PreProc")
  link("Delimiter", "Special")
  link("Exception", "Statement")
  link("Float", "Constant")
  link("Function", "Identifier")
  link("Include", "PreProc")
  link("Keyword", "Statement")
  link("Label", "Statement")
  link("LineNrAbove", "LineNr")
  link("LineNrBelow", "LineNr")
  link("Macro", "PreProc")
  link("MessageWindow", "WarningMsg")
  link("Number", "Constant")
  link("Operator", "Statement")
  link("PmenuKind", "Pmenu")
  link("PmenuKindSel", "PmenuSel")
  link("PmenuExtra", "Pmenu")
  link("PmenuExtraSel", "PmenuSel")
  link("PmenuMatch", "Pmenu")
  link("PmenuMatchSel", "PmenuSel")
  link("PopupNotification", "WarningMsg")
  link("PopupSelected", "PmenuSel")
  link("PreCondit", "PreProc")
  link("QuickFixLine", "Search")
  link("Repeat", "Statement")
  link("Removed", "diffRemoved")
  link("SpecialChar", "Special")
  link("SpecialComment", "Special")
  link("StatusLineTerm", "StatusLine")
  link("StatusLineTermNC", "StatusLineNC")
  link("StorageClass", "Type")
  link("String", "Constant")
  link("Structure", "Type")
  link("Tag", "Special")
  link("Typedef", "Type")
  link("debugBreakpoint", "SignColumn")
  link("debugPC", "SignColumn")
  link("lCursor", "Cursor")
end

-- TreeSitter highlights
function M.set_treesitter_highlights(colors)
  -- Identifiers
  hl("@variable", { fg = colors.fg_primary })
  hl("@variable.builtin", { fg = colors.identifier })
  hl("@variable.parameter", { fg = colors.fg_primary })
  hl("@variable.member", { fg = colors.identifier })
  
  -- Constants
  hl("@constant", { fg = colors.constant })
  hl("@constant.builtin", { fg = colors.constant })
  hl("@constant.macro", { fg = colors.preproc })
  
  -- Modules
  hl("@module", { fg = colors.identifier })
  hl("@module.builtin", { fg = colors.identifier })
  
  -- Labels
  hl("@label", { fg = colors.statement })
  
  -- Literals
  hl("@string", { fg = colors.string })
  hl("@string.documentation", { fg = colors.comment, italic = config.italic_comments })
  hl("@string.regexp", { fg = colors.special })
  hl("@string.escape", { fg = colors.special })
  hl("@string.special", { fg = colors.special })
  hl("@string.special.symbol", { fg = colors.identifier })
  hl("@string.special.url", { fg = colors.accent, underline = true })
  hl("@string.special.path", { fg = colors.string })
  
  hl("@character", { fg = colors.constant })
  hl("@character.special", { fg = colors.special })
  
  hl("@boolean", { fg = colors.constant })
  hl("@number", { fg = colors.constant })
  hl("@number.float", { fg = colors.constant })
  
  -- Types
  hl("@type", { fg = colors.type })
  hl("@type.builtin", { fg = colors.type })
  hl("@type.definition", { fg = colors.type })
  hl("@type.qualifier", { fg = colors.statement })
  
  hl("@attribute", { fg = colors.preproc })
  hl("@attribute.builtin", { fg = colors.preproc })
  hl("@property", { fg = colors.identifier })
  
  -- Functions
  hl("@function", { fg = colors.identifier })
  hl("@function.builtin", { fg = colors.identifier })
  hl("@function.call", { fg = colors.identifier })
  hl("@function.macro", { fg = colors.preproc })
  hl("@function.method", { fg = colors.identifier })
  hl("@function.method.call", { fg = colors.identifier })
  
  hl("@constructor", { fg = colors.type })
  
  -- Keywords
  hl("@keyword", { fg = colors.statement, bold = config.bold_keywords })
  hl("@keyword.coroutine", { fg = colors.statement, bold = config.bold_keywords })
  hl("@keyword.function", { fg = colors.statement, bold = config.bold_keywords })
  hl("@keyword.operator", { fg = colors.statement })
  hl("@keyword.import", { fg = colors.preproc })
  hl("@keyword.type", { fg = colors.statement })
  hl("@keyword.modifier", { fg = colors.statement })
  hl("@keyword.repeat", { fg = colors.statement, bold = config.bold_keywords })
  hl("@keyword.return", { fg = colors.statement, bold = config.bold_keywords })
  hl("@keyword.debug", { fg = colors.special })
  hl("@keyword.exception", { fg = colors.statement, bold = config.bold_keywords })
  hl("@keyword.conditional", { fg = colors.statement, bold = config.bold_keywords })
  hl("@keyword.conditional.ternary", { fg = colors.statement })
  hl("@keyword.directive", { fg = colors.preproc })
  hl("@keyword.directive.define", { fg = colors.preproc })
  
  -- Operators
  hl("@operator", { fg = colors.statement })
  
  -- Punctuation
  hl("@punctuation.delimiter", { fg = colors.fg_primary })
  hl("@punctuation.bracket", { fg = colors.fg_primary })
  hl("@punctuation.special", { fg = colors.special })
  
  -- Comments
  hl("@comment", { fg = colors.comment, italic = config.italic_comments })
  hl("@comment.documentation", { fg = colors.comment, italic = config.italic_comments })
  hl("@comment.error", { fg = colors.error, bold = true })
  hl("@comment.warning", { fg = colors.warning, bold = true })
  hl("@comment.todo", { fg = colors.info, bold = true })
  hl("@comment.note", { fg = colors.hint, bold = true })
  
  -- Markup
  hl("@markup.strong", { bold = true })
  hl("@markup.italic", { italic = true })
  hl("@markup.strikethrough", { strikethrough = true })
  hl("@markup.underline", { underline = true })
  hl("@markup.heading", { fg = colors.accent, bold = true })
  hl("@markup.heading.1", { fg = colors.accent, bold = true })
  hl("@markup.heading.2", { fg = colors.identifier, bold = true })
  hl("@markup.heading.3", { fg = colors.success, bold = true })
  hl("@markup.heading.4", { fg = colors.warning, bold = true })
  hl("@markup.heading.5", { fg = colors.error, bold = true })
  hl("@markup.heading.6", { fg = colors.magenta, bold = true })
  hl("@markup.quote", { fg = colors.comment, italic = true })
  hl("@markup.math", { fg = colors.special })
  hl("@markup.link", { fg = colors.accent, underline = true })
  hl("@markup.link.label", { fg = colors.accent })
  hl("@markup.link.url", { fg = colors.accent, underline = true })
  hl("@markup.raw", { fg = colors.string })
  hl("@markup.raw.block", { fg = colors.string })
  hl("@markup.list", { fg = colors.special })
  hl("@markup.list.checked", { fg = colors.success })
  hl("@markup.list.unchecked", { fg = colors.fg_secondary })
  
  -- Tags
  hl("@tag", { fg = colors.statement })
  hl("@tag.builtin", { fg = colors.statement })
  hl("@tag.attribute", { fg = colors.identifier })
  hl("@tag.delimiter", { fg = colors.fg_secondary })
end

-- LSP highlights
function M.set_lsp_highlights(colors)
  hl("LspReferenceText", { bg = colors.bg_secondary })
  hl("LspReferenceRead", { bg = colors.bg_secondary })
  hl("LspReferenceWrite", { bg = colors.bg_secondary, bold = true })
  hl("LspSignatureActiveParameter", { bg = colors.bg_secondary, bold = true })
  hl("LspCodeLens", { fg = colors.comment, italic = true })
  hl("LspCodeLensSeparator", { fg = colors.fg_muted })
  hl("LspInlayHint", { fg = colors.comment, italic = true })
end

-- Diagnostic highlights
function M.set_diagnostic_highlights(colors)
  hl("DiagnosticError", { fg = colors.error })
  hl("DiagnosticWarn", { fg = colors.warning })
  hl("DiagnosticInfo", { fg = colors.info })
  hl("DiagnosticHint", { fg = colors.hint })
  hl("DiagnosticOk", { fg = colors.success })
  
  hl("DiagnosticVirtualTextError", { fg = colors.error, bg = utils.blend(colors.error, colors.bg_primary, 0.1) })
  hl("DiagnosticVirtualTextWarn", { fg = colors.warning, bg = utils.blend(colors.warning, colors.bg_primary, 0.1) })
  hl("DiagnosticVirtualTextInfo", { fg = colors.info, bg = utils.blend(colors.info, colors.bg_primary, 0.1) })
  hl("DiagnosticVirtualTextHint", { fg = colors.hint, bg = utils.blend(colors.hint, colors.bg_primary, 0.1) })
  hl("DiagnosticVirtualTextOk", { fg = colors.success, bg = utils.blend(colors.success, colors.bg_primary, 0.1) })
  
  hl("DiagnosticUnderlineError", { sp = colors.error, underline = true })
  hl("DiagnosticUnderlineWarn", { sp = colors.warning, underline = true })
  hl("DiagnosticUnderlineInfo", { sp = colors.info, underline = true })
  hl("DiagnosticUnderlineHint", { sp = colors.hint, underline = true })
  hl("DiagnosticUnderlineOk", { sp = colors.success, underline = true })
  
  hl("DiagnosticFloatingError", { fg = colors.error })
  hl("DiagnosticFloatingWarn", { fg = colors.warning })
  hl("DiagnosticFloatingInfo", { fg = colors.info })
  hl("DiagnosticFloatingHint", { fg = colors.hint })
  hl("DiagnosticFloatingOk", { fg = colors.success })

  hl("DiagnosticSignError", { fg = colors.error, bg = colors.bg_primary })
  hl("DiagnosticSignWarn", { fg = colors.warning, bg = colors.bg_primary })
  hl("DiagnosticSignInfo", { fg = colors.info, bg = colors.bg_primary })
  hl("DiagnosticSignHint", { fg = colors.hint, bg = colors.bg_primary })
  hl("DiagnosticSignOk", { fg = colors.success, bg = colors.bg_primary })
end

-- Plugin-specific highlights (lazy loaded)
function M.set_plugin_highlights(colors)
  -- Indent Blankline
  if config.plugin_integrations.indent_blankline then
    hl("IblScope", { fg = colors.fg_secondary })
    hl("IblIndent", { fg = colors.fg_muted })
    hl("IblWhitespace", { fg = colors.fg_muted })
  end
  
  -- nvim-cmp
  if config.plugin_integrations.nvim_cmp and plugin_loaded('nvim-cmp') then
    hl("CmpItemAbbr", { fg = colors.fg_primary, bg = colors.bg_primary })
    hl("CmpItemMenu", { fg = colors.fg_primary, bg = colors.bg_primary })
    hl("CmpItemAbbrMatch", { fg = colors.accent, bg = colors.bg_primary, bold = true })
    hl("CmpItemAbbrMatchFuzzy", { fg = colors.accent, bg = colors.bg_primary, bold = true })
    hl("CmpItemKind", { fg = colors.identifier, bg = colors.bg_primary })
    hl("CmpItemKindText", { fg = colors.fg_primary })
    hl("CmpItemKindMethod", { fg = colors.identifier })
    hl("CmpItemKindFunction", { fg = colors.identifier })
    hl("CmpItemKindConstructor", { fg = colors.type })
    hl("CmpItemKindField", { fg = colors.identifier })
    hl("CmpItemKindVariable", { fg = colors.fg_primary })
    hl("CmpItemKindClass", { fg = colors.type })
    hl("CmpItemKindInterface", { fg = colors.type })
    hl("CmpItemKindModule", { fg = colors.identifier })
    hl("CmpItemKindProperty", { fg = colors.identifier })
    hl("CmpItemKindUnit", { fg = colors.constant })
    hl("CmpItemKindValue", { fg = colors.constant })
    hl("CmpItemKindEnum", { fg = colors.type })
    hl("CmpItemKindKeyword", { fg = colors.statement })
    hl("CmpItemKindSnippet", { fg = colors.special })
    hl("CmpItemKindColor", { fg = colors.special })
    hl("CmpItemKindFile", { fg = colors.fg_primary })
    hl("CmpItemKindReference", { fg = colors.accent })
    hl("CmpItemKindFolder", { fg = colors.accent })
    hl("CmpItemKindEnumMember", { fg = colors.constant })
    hl("CmpItemKindConstant", { fg = colors.constant })
    hl("CmpItemKindStruct", { fg = colors.type })
    hl("CmpItemKindEvent", { fg = colors.statement })
    hl("CmpItemKindOperator", { fg = colors.statement })
    hl("CmpItemKindTypeParameter", { fg = colors.type })
  end
  
  -- Gitsigns
  if config.plugin_integrations.gitsigns and plugin_loaded('gitsigns') then
    hl("GitSignsAdd", { fg = colors.git_add, bg = colors.bg_primary })
    hl("GitSignsChange", { fg = colors.git_change, bg = colors.bg_primary })
    hl("GitSignsDelete", { fg = colors.git_delete, bg = colors.bg_primary })
    hl("GitSignsAddNr", { fg = colors.git_add })
    hl("GitSignsChangeNr", { fg = colors.git_change })
    hl("GitSignsDeleteNr", { fg = colors.git_delete })
    hl("GitSignsAddLn", { bg = utils.blend(colors.git_add, colors.bg_primary, 0.1) })
    hl("GitSignsChangeLn", { bg = utils.blend(colors.git_change, colors.bg_primary, 0.1) })
    hl("GitSignsDeleteLn", { bg = utils.blend(colors.git_delete, colors.bg_primary, 0.1) })
  end
  
  -- Telescope
  if config.plugin_integrations.telescope and plugin_loaded('telescope') then
    hl("TelescopeBorder", { fg = colors.accent })
    hl("TelescopeSelection", { bg = colors.bg_secondary })
    hl("TelescopeSelectionCaret", { fg = colors.accent })
    hl("TelescopeMultiSelection", { fg = colors.accent })
    hl("TelescopeNormal", { fg = colors.fg_primary })
    hl("TelescopePreviewNormal", { fg = colors.fg_primary })
    hl("TelescopePromptNormal", { fg = colors.fg_primary })
    hl("TelescopeResultsNormal", { fg = colors.fg_primary })
    hl("TelescopeMatching", { fg = colors.accent, bold = true })
    hl("TelescopePromptPrefix", { fg = colors.accent })
  end
  
  -- nvim-tree
  if config.plugin_integrations.nvim_tree and plugin_loaded('nvim-tree') then
    hl("NvimTreeNormal", { fg = colors.fg_primary, bg = colors.bg_primary })
    hl("NvimTreeRootFolder", { fg = colors.accent, bold = true })
    hl("NvimTreeGitDirty", { fg = colors.git_change })
    hl("NvimTreeGitNew", { fg = colors.git_add })
    hl("NvimTreeGitDeleted", { fg = colors.git_delete })
    hl("NvimTreeSpecialFile", { fg = colors.special })
    hl("NvimTreeIndentMarker", { fg = colors.fg_muted })
    hl("NvimTreeImageFile", { fg = colors.magenta })
    hl("NvimTreeSymlink", { fg = colors.cyan })
    hl("NvimTreeFolderIcon", { fg = colors.accent })
  end
  
  -- which-key
  if config.plugin_integrations.which_key and plugin_loaded('which-key') then
    hl("WhichKey", { fg = colors.accent, bold = true })
    hl("WhichKeyGroup", { fg = colors.identifier })
    hl("WhichKeyDesc", { fg = colors.fg_primary })
    hl("WhichKeySeparator", { fg = colors.fg_secondary })
    hl("WhichKeyFloat", { bg = colors.bg_float })
    hl("WhichKeyBorder", { fg = colors.accent })
  end
end

-- Get user configuration (for external access)
function M.get_config()
  return config
end

-- Get colors (for external access)
function M.get_colors()
  return get_colors()
end

-- Toggle boring mode at runtime
function M.toggle_boring()
  config.boring = not config.boring
  M.load()
  print("DarkTrial: boring mode " .. (config.boring and "enabled" or "disabled"))
end

-- Auto-setup when loaded (maintains backward compatibility)
if not config or vim.tbl_isempty(config) then
  M.setup()
end

return M
