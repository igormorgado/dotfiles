-- Name:         DarkTrial
-- Description:  A dark theme for boring people (Enhanced Edition)
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
--     boring = true,           -- Use monochromatic syntax
--     dim_inactive = true,     -- Dim inactive windows
--     contrast = "high",       -- "low", "medium", "high"
--   })
--   vim.cmd('colorscheme darktrial')
--
--   -- Toggle functions at runtime
--   :lua require('darktrial').toggle_boring()
--   :lua require('darktrial').toggle_transparent()
--   :lua require('darktrial').toggle_dim_inactive()
--   :lua require('darktrial').cycle_contrast()
--   :lua require('darktrial').check_contrast()
--   :lua require('darktrial').help()

local M = {}

-- Default configuration
local default_config = {
  transparent_background = false,  -- Enable transparent background
  italic_comments = true,          -- Use italic for comments
  italic_constants = true,         -- Use italic for constants
  bold_keywords = true,            -- Use bold for keywords/statements
  bold_special = true,             -- Use bold for special elements
  boring = false,                  -- Use monochromatic syntax (no colors for strings, keywords, special)
  dim_inactive = false,            -- Dim inactive windows
  contrast = "medium",             -- Contrast level: "low", "medium", "high"
  enable_treesitter = true,        -- Enable TreeSitter highlights
  enable_lsp = true,               -- Enable LSP highlights
  enable_diagnostics = true,       -- Enable diagnostic highlights
  enable_semantic_tokens = true,   -- Enable LSP semantic token highlights
  plugin_integrations = {
    indent_blankline = true,       -- Enable indent-blankline highlights
    nvim_cmp = true,               -- Enable nvim-cmp highlights
    gitsigns = true,               -- Enable gitsigns highlights
    telescope = true,              -- Enable telescope highlights
    nvim_tree = true,              -- Enable nvim-tree highlights
    which_key = true,              -- Enable which-key highlights
    bufferline = true,             -- Enable bufferline highlights
    lualine = true,                -- Enable lualine highlights
    neogit = true,                 -- Enable neogit highlights
    fugitive = true,               -- Enable vim-fugitive highlights
    trouble = true,                -- Enable trouble.nvim highlights
    copilot = true,                -- Enable copilot.lua highlights
    undotree = true,               -- Enable undotree highlights
    vim_signature = true,          -- Enable vim-signature highlights
    comment = true,                -- Enable Comment.nvim highlights
  },
}

-- User configuration (will be merged with defaults)
local config = {}

local raw_colors = {
  none       = "NONE",

  -- Base palette
  black      = "#121212",
  red        = "#d2191a",
  green      = "#076b47",
  brown      = "#d27519",
  blue       = "#1976d2",
  purple     = "#7519d2",
  teal       = "#005c7d",
  white      = "#e3e3e3",
  darkgray   = "#383838",
  orange     = "#ef8911",
  lime       = "#1ad219",
  yellow     = "#d2d119",
  indigo     = "#84a7f2",
  magenta    = "#d119d2",
  cyan       = "#39e7d8",
  whitesmoke = "#f1f1f1",

  -- Extra colors
  bg_darker  = "#0a0a0a",
  bg_lighter = "#1a1a1a",
  gray0      = "#2a2a2a",
  gray1      = "#303030",
  gray2      = "#3a3a3a",
  gray3      = "#5e5e5e",
  gray4      = "#6e6e6e"
}

raw_colors.highcol      = raw_colors.bg_lighter
-- Aliases for 16-color palette and bright variants
raw_colors.color0       = raw_colors.black
raw_colors.color1       = raw_colors.red
raw_colors.color2       = raw_colors.green
raw_colors.color3       = raw_colors.brown
raw_colors.color4       = raw_colors.blue
raw_colors.color5       = raw_colors.purple
raw_colors.color6       = raw_colors.teal
raw_colors.color7       = raw_colors.white
raw_colors.color8       = raw_colors.darkgray
raw_colors.color9       = raw_colors.orange
raw_colors.color10      = raw_colors.lime
raw_colors.color11      = raw_colors.yellow
raw_colors.color12      = raw_colors.indigo
raw_colors.color13      = raw_colors.magenta
raw_colors.color14      = raw_colors.cyan
raw_colors.color15      = raw_colors.whitesmoke

raw_colors.brightblack  = raw_colors.darkgray
raw_colors.brightred    = raw_colors.orange
raw_colors.brightgreen  = raw_colors.lime
raw_colors.brightbrown  = raw_colors.yellow
raw_colors.brightblue   = raw_colors.indigo
raw_colors.brightpurple = raw_colors.magenta
raw_colors.brightcyan   = raw_colors.cyan
raw_colors.brightwhite  = raw_colors.whitesmoke

-- Color utilities
local utils = {}

-- Convert hex to RGB
utils.hex_to_rgb = function(hex)
  if hex == "NONE" then return { r = 0, g = 0, b = 0 } end
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
  if color == "NONE" then return "NONE" end
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
  if color == "NONE" then return "NONE" end
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
  if color1 == "NONE" then return color2 end
  if color2 == "NONE" then return color1 end
  local rgb1 = utils.hex_to_rgb(color1)
  local rgb2 = utils.hex_to_rgb(color2)
  return utils.rgb_to_hex(
    math.floor(rgb1.r * (1 - ratio) + rgb2.r * ratio),
    math.floor(rgb1.g * (1 - ratio) + rgb2.g * ratio),
    math.floor(rgb1.b * (1 - ratio) + rgb2.b * ratio)
  )
end

-- Calculate relative luminance (WCAG formula)
utils.get_luminance = function(color)
  if color == "NONE" then return 0 end
  local rgb = utils.hex_to_rgb(color)
  local function adjust(c)
    c = c / 255
    return c <= 0.03928 and c / 12.92 or math.pow((c + 0.055) / 1.055, 2.4)
  end
  return 0.2126 * adjust(rgb.r) + 0.7152 * adjust(rgb.g) + 0.0722 * adjust(rgb.b)
end

-- Calculate contrast ratio between two colors
utils.contrast_ratio = function(color1, color2)
  local l1 = utils.get_luminance(color1)
  local l2 = utils.get_luminance(color2)
  local lighter = math.max(l1, l2)
  local darker = math.min(l1, l2)
  return (lighter + 0.05) / (darker + 0.05)
end

-- Semantic color names based on raw colors
local function get_colors()
  local background = config.transparent_background and "NONE" or raw_colors.black

  -- Apply contrast adjustments
  local contrast_adjustments = {
    low = { bg_mult = 1.15, fg_mult = 0.92 },
    medium = { bg_mult = 1.0, fg_mult = 1.0 },
    high = { bg_mult = 0.85, fg_mult = 1.08 },
  }

  local adj = contrast_adjustments[config.contrast] or contrast_adjustments.medium

  -- Helper to adjust colors based on contrast setting
  local function adjust_bg(color)
    if color == "NONE" or adj.bg_mult == 1.0 then return color end
    if adj.bg_mult > 1.0 then
      return utils.lighten(color, (adj.bg_mult - 1.0) * 100)
    else
      return utils.darken(color, (1.0 - adj.bg_mult) * 100)
    end
  end

  local function adjust_fg(color)
    if color == "NONE" or adj.fg_mult == 1.0 then return color end
    if adj.fg_mult > 1.0 then
      return utils.lighten(color, (adj.fg_mult - 1.0) * 100)
    else
      return utils.darken(color, (1.0 - adj.fg_mult) * 100)
    end
  end

  return {
    -- Background colors
    bg_primary = background,
    bg_darker = adjust_bg(raw_colors.bg_darker),
    bg_lighter = adjust_bg(raw_colors.bg_lighter),
    bg_secondary = adjust_bg(raw_colors.highcol),
    bg_accent = adjust_bg(raw_colors.brightblack),
    bg_float = adjust_bg(raw_colors.brightblack),

    -- Foreground colors
    fg_primary = adjust_fg(raw_colors.white),
    fg_secondary = adjust_fg(raw_colors.brightwhite),
    fg_muted = adjust_fg(raw_colors.brightblack),

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
    diff_text = raw_colors.purple,

    -- Git colors
    git_add = raw_colors.green,
    git_change = raw_colors.yellow,
    git_delete = raw_colors.red,

    -- Syntax colors
    comment = adjust_fg(raw_colors.darkgray),
    constant = adjust_fg(raw_colors.white),
    string = config.boring and adjust_fg(raw_colors.white) or raw_colors.green,
    identifier = raw_colors.blue,
    statement = config.boring and adjust_fg(raw_colors.white) or raw_colors.brown,
    preproc = adjust_fg(raw_colors.white),
    type = adjust_fg(raw_colors.brightwhite),
    special = config.boring and adjust_fg(raw_colors.white) or raw_colors.purple,

    -- Raw colors (for compatibility)
    black         =  raw_colors.black       ,
    red           =  raw_colors.red         ,
    green         =  raw_colors.green       ,
    brown         =  raw_colors.brown       ,
    blue          =  raw_colors.blue        ,
    purple        =  raw_colors.purple      ,
    teal          =  raw_colors.teal        ,
    white         =  raw_colors.white       ,
    darkgray      =  raw_colors.darkgray    ,
    brightblack   =  raw_colors.brightblack ,
    orange        =  raw_colors.orange      ,
    brightred     =  raw_colors.brightred   ,
    lime          =  raw_colors.lime        ,
    brightgreen   =  raw_colors.brightgreen ,
    yellow        =  raw_colors.yellow      ,
    brightbrown   =  raw_colors.brightbrown ,
    indigo        =  raw_colors.indigo      ,
    brightblue    =  raw_colors.brightblue  ,
    magenta       =  raw_colors.magenta     ,
    brightpurple  =  raw_colors.brightpurple,
    cyan          =  raw_colors.cyan        ,
    brightcyan    =  raw_colors.brightcyan  ,
    whitesmoke    =  raw_colors.whitesmoke  ,
    brightwhite   =  raw_colors.brightwhite ,
    bg_darker     =  raw_colors.bg_darker   ,
    bg_lighter    =  raw_colors.bg_lighter  ,
    gray1         =  raw_colors.gray1       ,
    gray2         =  raw_colors.gray2       ,
    gray3         =  raw_colors.gray3       ,
    gray4         =  raw_colors.gray4       ,
    highcol       =  raw_colors.highcol
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

  -- Check for italic support (ensure boolean)
  local has_italics = vim.fn.has('gui_running') == 1 or
                     (vim.env.TERM and (vim.env.TERM:match('xterm') ~= nil or vim.env.TERM:match('screen') ~= nil or vim.env.TERM:match('tmux') ~= nil))

  -- Convert to proper boolean and override based on config
  has_italics = has_italics and true or false
  if not config.italic_comments then has_italics = false end

  -- Terminal colors
  vim.g.terminal_ansi_colors = {
    colors.black,
    colors.red,
    colors.green,
    colors.brown,
    colors.blue,
    colors.purple,
    colors.cyan,
    colors.white,
    colors.brightblack,
    colors.brightred,
    colors.brightgreen,
    colors.brightbrown,
    colors.brightblue,
    colors.brightpurple,
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

  -- Improved diff highlights (subtle background blending instead of reverse)
  hl("DiffAdd", { bg = utils.blend(colors.diff_add, colors.bg_primary, 0.2) })
  hl("DiffChange", { bg = utils.blend(colors.diff_change, colors.bg_primary, 0.15) })
  hl("DiffDelete", { fg = colors.diff_delete, bg = utils.blend(colors.diff_delete, colors.bg_primary, 0.15) })
  hl("DiffText", { bg = utils.blend(colors.diff_text, colors.bg_primary, 0.25), bold = true })
  hl("diffAdded", { fg = colors.diff_add })
  hl("diffRemoved", { fg = colors.diff_delete })
  hl("diffChanged", { fg = colors.diff_change })
  hl("diffOldFile", { fg = colors.diff_delete })
  hl("diffNewFile", { fg = colors.diff_add })
  hl("diffFile", { fg = colors.accent, bold = true })
  hl("diffLine", { fg = colors.info })
  hl("diffIndexLine", { fg = colors.fg_secondary })

  hl("Directory", { fg = colors.accent })
  hl("EndOfBuffer", {})
  hl("ErrorMsg", { fg = colors.error, bg = colors.bg_primary, reverse = true })
  hl("FoldColumn", { fg = colors.fg_muted, bg = colors.bg_primary })
  hl("Folded", {
    fg = colors.fg_secondary,
    bg = utils.blend(colors.bg_accent, colors.bg_primary, 0.5),
    italic = has_italics
  })
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

  -- Improved spell checking (undercurl instead of background)
  hl("SpellBad", { sp = colors.error, undercurl = true })
  hl("SpellCap", { sp = colors.info, undercurl = true })
  hl("SpellLocal", { sp = colors.hint, undercurl = true })
  hl("SpellRare", { sp = colors.warning, undercurl = true })

  -- StatusLine with mode-specific colors
  hl("StatusLine", { bg = colors.accent, bold = true })
  hl("StatusLineNC", { bg = colors.bg_accent })
  hl("StatusLineNormal", { fg = colors.bg_primary, bg = colors.accent, bold = true })
  hl("StatusLineInsert", { fg = colors.bg_primary, bg = colors.success, bold = true })
  hl("StatusLineVisual", { fg = colors.bg_primary, bg = colors.warning, bold = true })
  hl("StatusLineReplace", { fg = colors.bg_primary, bg = colors.error, bold = true })
  hl("StatusLineCommand", { fg = colors.bg_primary, bg = colors.purple, bold = true })

  hl("TabLine", { bg = colors.bg_accent, bold = true })
  hl("TabLineFill", { })
  hl("TabLineSel", { fg = colors.fg_primary, bg = colors.accent, bold = true })
  hl("Title", { fg = colors.fg_muted, bg = colors.accent })
  hl("VertSplit", { fg = colors.accent, bg = colors.bg_primary, bold = true })
  hl("Visual", { fg = colors.bg_primary, bg = colors.fg_primary })
  hl("VisualNOS", { fg = colors.fg_primary, bg = colors.bg_primary, underline = true })
  hl("WarningMsg", { fg = colors.bg_primary, bg = colors.warning })
  hl("WildMenu", { fg = colors.fg_primary, bg = colors.bg_primary })

  -- Window dimming for inactive windows
  if config.dim_inactive then
    hl("NormalNC", { fg = utils.darken(colors.fg_primary, 15), bg = colors.bg_primary })
    hl("LineNrNC", { fg = utils.darken(colors.fg_muted, 20) })
  end

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
    M.set_treesitter_highlights(colors, has_italics)
  end

  -- LSP and diagnostic highlights (when enabled)
  if config.enable_lsp then
    M.set_lsp_highlights(colors)
  end

  if config.enable_semantic_tokens then
    M.set_semantic_token_highlights(colors)
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
function M.set_treesitter_highlights(colors, has_italics)
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
  hl("@comment", { fg = colors.comment, italic = has_italics and config.italic_comments })
  hl("@comment.documentation", { fg = colors.comment, italic = has_italics and config.italic_comments })
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
  hl("@markup.heading.6", { fg = colors.brightpurple, bold = true })
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

  -- Additional captures
  hl("@none", { fg = "NONE" })
  hl("@conceal", { link = "Conceal" })
  hl("@spell", {})
  hl("@nospell", {})

  -- Diff
  hl("@diff.plus", { link = "diffAdded" })
  hl("@diff.minus", { link = "diffRemoved" })
  hl("@diff.delta", { link = "diffChanged" })

  -- Text annotations
  hl("@text.danger", { fg = colors.error, bold = true })
  hl("@text.warning", { fg = colors.warning, bold = true })
  hl("@text.note", { fg = colors.info, bold = true })
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

-- LSP Semantic Token highlights
function M.set_semantic_token_highlights(colors)
  -- Types
  hl("@lsp.type.namespace", { fg = colors.identifier })
  hl("@lsp.type.type", { fg = colors.type })
  hl("@lsp.type.class", { fg = colors.type, bold = true })
  hl("@lsp.type.enum", { fg = colors.type })
  hl("@lsp.type.interface", { fg = colors.type })
  hl("@lsp.type.struct", { fg = colors.type })
  hl("@lsp.type.parameter", { fg = colors.fg_primary })
  hl("@lsp.type.variable", { fg = colors.fg_primary })
  hl("@lsp.type.property", { fg = colors.identifier })
  hl("@lsp.type.enumMember", { fg = colors.constant })
  hl("@lsp.type.function", { fg = colors.identifier })
  hl("@lsp.type.method", { fg = colors.identifier })
  hl("@lsp.type.macro", { fg = colors.preproc })
  hl("@lsp.type.decorator", { fg = colors.special })
  hl("@lsp.type.comment", { link = "Comment" })

  -- Modifiers
  hl("@lsp.mod.readonly", { fg = colors.constant })
  hl("@lsp.mod.deprecated", { fg = colors.fg_muted, strikethrough = true })
  hl("@lsp.mod.static", { fg = colors.constant, italic = true })
  hl("@lsp.mod.abstract", { fg = colors.type, italic = true })
  hl("@lsp.mod.async", { fg = colors.statement, italic = true })
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
    hl("NvimTreeImageFile", { fg = colors.purple })
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

  -- BufferLine
  if config.plugin_integrations.bufferline and plugin_loaded('bufferline') then
    hl("BufferLineIndicatorSelected", { fg = colors.accent })
    hl("BufferLineFill", { bg = utils.darken(colors.bg_primary, 10) })
    hl("BufferLineBackground", { fg = colors.fg_secondary, bg = colors.bg_primary })
    hl("BufferLineBufferSelected", { fg = colors.accent, bold = true })
    hl("BufferLineModified", { fg = colors.warning })
    hl("BufferLineModifiedSelected", { fg = colors.warning, bold = true })
    hl("BufferLineTab", { fg = colors.fg_secondary, bg = colors.bg_primary })
    hl("BufferLineTabSelected", { fg = colors.accent, bg = colors.bg_primary, bold = true })
    hl("BufferLineDuplicate", { fg = colors.fg_muted, bg = colors.bg_primary })
    hl("BufferLineDuplicateSelected", { fg = colors.accent, bg = colors.bg_primary, bold = true })
  end

  -- Lualine
  if config.plugin_integrations.lualine and plugin_loaded('lualine') then
    -- Inherit StatusLine colors instead of redefining them
    hl("lualine_a_normal",  { link = "StatusLineNormal" })
    hl("lualine_a_insert",  { link = "StatusLineInsert" })
    hl("lualine_a_visual",  { link = "StatusLineVisual" })
    hl("lualine_a_replace", { link = "StatusLineReplace" })
    hl("lualine_a_command", { link = "StatusLineCommand" })

    hl("lualine_b_normal", { link = "StatusLine" })
    hl("lualine_c_normal", { link = "StatusLine" })

    -- Templates for other mode-specific sections (uncomment to customize)
    -- hl("lualine_b_insert",  { link = "StatusLineInsert" })
    -- hl("lualine_c_insert",  { link = "StatusLineInsert" })
    -- hl("lualine_b_visual",  { link = "StatusLineVisual" })
    -- hl("lualine_c_visual",  { link = "StatusLineVisual" })
    -- hl("lualine_b_replace", { link = "StatusLineReplace" })
    -- hl("lualine_c_replace", { link = "StatusLineReplace" })
    -- hl("lualine_b_command", { link = "StatusLineCommand" })
    -- hl("lualine_c_command", { link = "StatusLineCommand" })
  end

  -- Neogit
  if config.plugin_integrations.neogit and plugin_loaded('neogit') then
    hl("NeogitDiffAdd", { link = "DiffAdd" })
    hl("NeogitDiffDelete", { link = "DiffDelete" })
    hl("NeogitDiffContext", { fg = colors.fg_secondary })
    hl("NeogitDiffContextHighlight", { bg = colors.bg_secondary })
    hl("NeogitHunkHeader", { fg = colors.accent, bold = true })
    hl("NeogitHunkHeaderHighlight", { fg = colors.accent, bg = colors.bg_secondary, bold = true })
    hl("NeogitChangeModified", { fg = colors.git_change, bold = true })
    hl("NeogitChangeAdded", { fg = colors.git_add, bold = true })
    hl("NeogitChangeDeleted", { fg = colors.git_delete, bold = true })
    hl("NeogitChangeRenamed", { fg = colors.purple, bold = true })
    hl("NeogitChangeUpdated", { fg = colors.cyan, bold = true })
    hl("NeogitChangeCopied", { fg = colors.cyan, bold = true })
    hl("NeogitChangeBothModified", { fg = colors.warning, bold = true })
    hl("NeogitChangeNewFile", { fg = colors.git_add, bold = true })
  end

  -- Fugitive
  if config.plugin_integrations.fugitive and plugin_loaded('fugitive') then
    hl("fugitiveHeader", { fg = colors.accent, bold = true })
    hl("fugitiveHeading", { fg = colors.accent, bold = true })
    hl("fugitiveUntrackedHeading", { fg = colors.fg_secondary, bold = true })
    hl("fugitiveUnstagedHeading", { fg = colors.warning, bold = true })
    hl("fugitiveStagedHeading", { fg = colors.success, bold = true })
    hl("fugitiveUntrackedModifier", { fg = colors.fg_secondary })
    hl("fugitiveUnstagedModifier", { fg = colors.warning })
    hl("fugitiveStagedModifier", { fg = colors.success })
  end

  -- Trouble
  if config.plugin_integrations.trouble and plugin_loaded('trouble') then
    hl("TroubleText", { fg = colors.fg_primary })
    hl("TroubleCount", { fg = colors.purple, bold = true })
    hl("TroubleNormal", { fg = colors.fg_primary, bg = colors.bg_primary })
    hl("TroubleTextError", { fg = colors.error })
    hl("TroubleTextWarning", { fg = colors.warning })
    hl("TroubleTextInformation", { fg = colors.info })
    hl("TroubleTextHint", { fg = colors.hint })
    hl("TroubleSource", { fg = colors.fg_secondary })
    hl("TroubleCode", { fg = colors.fg_secondary })
    hl("TroubleLocation", { fg = colors.fg_secondary })
    hl("TroubleFoldIcon", { fg = colors.accent })
    hl("TroubleIndent", { fg = colors.fg_muted })
  end

  -- Copilot
  if config.plugin_integrations.copilot and plugin_loaded('copilot') then
    hl("CopilotSuggestion", { fg = colors.fg_muted, italic = true })
    hl("CopilotAnnotation", { fg = colors.fg_muted, italic = true })
  end

  -- Undotree
  if config.plugin_integrations.undotree then
    hl("UndotreeSavedBig", { fg = colors.error, bold = true })
    hl("UndotreeSavedSmall", { fg = colors.error })
    hl("UndotreeNode", { fg = colors.accent })
    hl("UndotreeNodeCurrent", { fg = colors.success, bold = true })
    hl("UndotreeSeq", { fg = colors.fg_secondary })
    hl("UndotreeTime", { fg = colors.fg_muted })
    hl("UndotreeHead", { fg = colors.warning, bold = true })
    hl("UndotreeBranch", { fg = colors.purple })
    hl("UndotreeCurrent", { fg = colors.success, bold = true })
    hl("UndotreeNext", { fg = colors.accent })
  end

  -- vim-signature (marks)
  if config.plugin_integrations.vim_signature then
    hl("SignatureMarkText", { fg = colors.accent, bg = colors.bg_primary, bold = true })
    hl("SignatureMarkerText", { fg = colors.warning, bg = colors.bg_primary, bold = true })
    hl("SignColumn", { fg = colors.fg_muted, bg = colors.bg_primary })
  end

  -- Comment.nvim (uses default Comment highlight)
  if config.plugin_integrations.comment then
    -- Comment.nvim uses the default Comment highlight group
    -- No additional highlights needed
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

  -- Force indent-blankline to refresh with new highlights
  vim.schedule(function()
    local ok, ibl = pcall(require, 'ibl')
    if ok then
      ibl.update({})
    end
  end)
end

-- Toggle transparent background
function M.toggle_transparent()
  config.transparent_background = not config.transparent_background
  M.load()
  print("DarkTrial: transparent background " .. (config.transparent_background and "enabled" or "disabled"))

  -- Force indent-blankline to refresh with new highlights
  vim.schedule(function()
    local ok, ibl = pcall(require, 'ibl')
    if ok then
      ibl.update({})
    end
  end)
end

-- Toggle dim inactive windows
function M.toggle_dim_inactive()
  config.dim_inactive = not config.dim_inactive
  M.load()
  print("DarkTrial: dim inactive windows " .. (config.dim_inactive and "enabled" or "disabled"))

  -- Force indent-blankline to refresh with new highlights
  vim.schedule(function()
    local ok, ibl = pcall(require, 'ibl')
    if ok then
      ibl.update({})
    end
  end)
end

-- Cycle through contrast levels
function M.cycle_contrast()
  local levels = { "low", "medium", "high" }
  local current_idx = 1
  for i, level in ipairs(levels) do
    if config.contrast == level then
      current_idx = i
      break
    end
  end
  config.contrast = levels[(current_idx % #levels) + 1]
  M.load()
  print("DarkTrial: contrast = " .. config.contrast)

  -- Force indent-blankline to refresh with new highlights
  vim.schedule(function()
    local ok, ibl = pcall(require, 'ibl')
    if ok then
      ibl.update({})
    end
  end)
end

-- Check contrast ratio (WCAG compliance)
function M.check_contrast()
  local colors = get_colors()
  if colors.bg_primary == "NONE" then
    print("Cannot check contrast with transparent background")
    return
  end
  local ratio = utils.contrast_ratio(colors.fg_primary, colors.bg_primary)
  print(string.format("Contrast ratio: %.2f:1 %s", ratio,
    ratio >= 7.0 and "(WCAG AAA ✓)" or
    ratio >= 4.5 and "(WCAG AA ✓)" or
    "(WCAG AA ✗)"))
  return ratio
end

-- Help function
function M.help()
  print([[
DarkTrial Colorscheme - Enhanced Edition

Commands:
  :lua require('darktrial').toggle_boring()      -- Toggle monochrome syntax mode
  :lua require('darktrial').toggle_transparent() -- Toggle transparent background
  :lua require('darktrial').toggle_dim_inactive()-- Toggle dim inactive windows
  :lua require('darktrial').cycle_contrast()     -- Cycle contrast: low → medium → high
  :lua require('darktrial').check_contrast()     -- Check WCAG contrast ratio
  :lua require('darktrial').get_colors()         -- Get current color palette
  :lua require('darktrial').get_config()         -- Get current configuration
  :lua require('darktrial').help()               -- Show this help

User Commands:
  :DarktrialToggleBoring      -- Toggle boring mode
  :DarktrialToggleTransparent -- Toggle transparent background
  :DarktrialToggleDimInactive -- Toggle dim inactive windows
  :DarktrialCycleContrast     -- Cycle contrast levels
  :DarktrialCheckContrast     -- Check WCAG contrast ratio
  :DarktrialHelp              -- Show this help

Configuration Example:
  require('darktrial').setup({
    transparent_background = false,
    italic_comments = true,
    bold_keywords = true,
    boring = false,
    dim_inactive = false,
    contrast = "medium",  -- "low", "medium", "high"
    plugin_integrations = {
      bufferline = true,
      lualine = true,
      telescope = true,
      -- ... and more
    },
  })
  vim.cmd('colorscheme darktrial')

For more info: https://www.fer.mat
  ]])
end

-- Auto-setup when loaded (maintains backward compatibility)
if not config or vim.tbl_isempty(config) then
  M.setup()
end

-- Register the module so it can be accessed via require/package.loaded
package.loaded['darktrial'] = M

return M
