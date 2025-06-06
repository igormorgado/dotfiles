" Name:         DarkTrial
" Description:  A dark theme for boring people
" Author:       Igor Morgado <morgado.igor@gmail.com>
" Maintainer:   Igor Morgado <morgado.igor@gmail.com>
" Website:      https://www.fer.mat
" License:      Public domain
" Last Change:  2025 Mar 16

" Generated by Colortemplate v2.2.3

set background=dark

hi clear
let g:colors_name = 'darktrial'

let s:t_Co = has('gui_running') ? -1 : (&t_Co ?? 0)

" Damn xterm-kitty with neovim
if (exists('&t_ZH') && &t_ZH != '') || has('gui_running') || &term =~ 'xterm' || &term =~ 'screen' || &term =~ 'tmux'
  let s:italics = 1
else
  let s:italics = 0
endif

hi! link Added diffAdded
hi! link Boolean Constant
hi! link Character Constant
hi! link Changed diffChanged
hi! link Conditional Statement
hi! link CurSearch IncSearch
hi! link CursorLineFold FoldColumn
hi! link CursorLineSign SignColumn
hi! link Debug Special
hi! link Define PreProc
hi! link Delimiter Special
hi! link Exception Statement
hi! link Float Constant
hi! link Function Identifier
hi! link Include PreProc
hi! link Keyword Statement
hi! link Label Statement
hi! link LineNrAbove LineNr
hi! link LineNrBelow LineNr
hi! link Macro PreProc
hi! link MessageWindow WarningMsg
hi! link Number Constant
hi! link Operator Statement
hi! link PmenuKind Pmenu
hi! link PmenuKindSel PmenuSel
hi! link PmenuExtra Pmenu
hi! link PmenuExtraSel PmenuSel
hi! link PmenuMatch Pmenu
hi! link PmenuMatchSel PmenuSel
hi! link PopupNotification WarningMsg
hi! link PopupSelected PmenuSel
hi! link PreCondit PreProc
hi! link QuickFixLine Search
hi! link Repeat Statement
hi! link Removed diffRemoved
hi! link SpecialChar Special
hi! link SpecialComment Special
hi! link StatusLineTerm StatusLine
hi! link StatusLineTermNC StatusLineNC
hi! link StorageClass Type
hi! link String Constant
hi! link Structure Type
hi! link Tag Special
hi! link Typedef Type
hi! link debugBreakpoint SignColumn
hi! link debugPC SignColumn
hi! link lCursor Cursor

if (has('termguicolors') && &termguicolors) || has('gui_running')
  let g:terminal_ansi_colors = ['#121212', '#ff7c3b', '#48d56b', '#f2d085', '#84a7f2', '#ff66e4', '#39e7d8', '#eeeeee', '#4e4e4e', '#b51530', '#076b47', '#934305', '#10237a', '#9700b7', '#005c7d', '#b2b2b2']
endif
if get(g:, 'darktrial_transp_bg', 0) && !has('gui_running')
  hi Normal guifg=#eeeeee guibg=NONE gui=NONE cterm=NONE
  hi Terminal guifg=#eeeeee guibg=NONE gui=NONE cterm=NONE
else
  hi Normal guifg=#eeeeee guibg=#121212 gui=NONE cterm=NONE
  hi Terminal guifg=#eeeeee guibg=#121212 gui=NONE cterm=NONE
endif
hi ColorColumn guifg=fg guibg=#934305 gui=NONE cterm=NONE
hi Conceal guifg=NONE guibg=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi Cursor guifg=NONE guibg=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi CursorColumn guifg=NONE guibg=#303030 gui=NONE cterm=NONE
hi CursorLine guifg=NONE guibg=#303030 gui=NONE cterm=NONE
hi CursorLineNr guifg=#eeeeee guibg=NONE gui=bold cterm=bold
hi DiffAdd guifg=#48d56b guibg=NONE gui=reverse cterm=reverse
hi DiffChange guifg=#39e7d8 guibg=NONE gui=reverse cterm=reverse
hi DiffDelete guifg=#ff7c3b guibg=NONE gui=reverse cterm=reverse
hi DiffText guifg=#ff66e4 guibg=NONE gui=bold,reverse cterm=bold,reverse
hi Directory guifg=#84a7f2 guibg=NONE gui=NONE cterm=NONE
hi EndOfBuffer guifg=NONE guibg=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi ErrorMsg guifg=#ff7c3b guibg=#121212 gui=reverse cterm=reverse
hi FoldColumn guifg=#4e4e4e guibg=#121212 gui=NONE cterm=NONE
hi Folded guifg=#b2b2b2 guibg=#4e4e4e gui=italic cterm=italic
hi IncSearch guifg=#eeeeee guibg=#121212 gui=standout cterm=reverse
hi LineNr guifg=#4e4e4e guibg=#121212 gui=NONE cterm=NONE
hi MatchParen guifg=#121212 guibg=#f2d085 gui=NONE cterm=NONE
hi ModeMsg guifg=#121212 guibg=#48d56b gui=bold cterm=bold
hi MoreMsg guifg=#121212 guibg=#48d56b gui=bold cterm=bold
hi NonText guifg=#b2b2b2 guibg=NONE gui=NONE cterm=NONE
hi Pmenu guifg=#121212 guibg=#b2b2b2 gui=NONE cterm=NONE
hi PmenuSbar guifg=#121212 guibg=#eeeeee gui=NONE cterm=NONE
hi PmenuSel guifg=NONE guibg=NONE gui=reverse ctermfg=NONE ctermbg=NONE cterm=reverse
hi PmenuThumb guifg=NONE guibg=#84a7f2 gui=NONE cterm=NONE
hi Question guifg=#121212 guibg=#48d56b gui=NONE cterm=NONE
hi Search guifg=#eeeeee guibg=#121212 gui=bold,reverse cterm=bold,reverse
hi SignColumn guifg=#4e4e4e guibg=#121212 gui=NONE cterm=NONE
hi SpecialKey guifg=#b2b2b2 guibg=NONE gui=NONE cterm=NONE
hi SpellBad guifg=NONE guibg=#b51530 guisp=#b51530 gui=NONE cterm=NONE
hi SpellCap guifg=NONE guibg=#84a7f2 guisp=#10237a gui=NONE cterm=NONE
hi SpellLocal guifg=NONE guibg=#ff66e4 guisp=#9700b7 gui=NONE cterm=NONE
hi SpellRare guifg=NONE guibg=#005c7d guisp=#005c7d gui=NONE cterm=NONE
hi StatusLine guifg=NONE guibg=#84a7f2 gui=bold cterm=bold
hi StatusLineNC guifg=NONE guibg=#4e4e4e gui=NONE cterm=NONE
hi StatusLineTerm guifg=NONE guibg=#48d56b gui=bold cterm=bold
hi StatusLineTermNC guifg=NONE guibg=#4e4e4e gui=NONE cterm=NONE
hi TabLine guifg=NONE guibg=#4e4e4e gui=bold cterm=bold
hi TabLineFill guifg=NONE guibg=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi TabLineSel guifg=#eeeeee guibg=#84a7f2 gui=bold cterm=bold
hi Title guifg=#4e4e4e guibg=#84a7f2 gui=NONE cterm=NONE
hi VertSplit guifg=#84a7f2 guibg=#121212 gui=bold cterm=bold
hi Visual guifg=NONE guibg=NONE gui=reverse ctermfg=NONE ctermbg=NONE cterm=reverse
hi VisualNOS guifg=#eeeeee guibg=#121212 gui=NONE cterm=NONE
hi WarningMsg guifg=#121212 guibg=#f2d085 gui=NONE cterm=NONE
hi WildMenu guifg=#eeeeee guibg=#121212 gui=NONE cterm=NONE
hi Comment guifg=#b2b2b2 guibg=NONE gui=italic cterm=italic
hi Constant guifg=#eeeeee guibg=NONE gui=italic cterm=italic
hi Error guifg=#eeeeee guibg=#ff7c3b gui=reverse cterm=reverse
hi Identifier guifg=#84a7f2 guibg=NONE gui=NONE cterm=NONE
hi Ignore guifg=#48d56b guibg=NONE gui=NONE cterm=NONE
hi PreProc guifg=#eeeeee guibg=NONE gui=NONE cterm=NONE
hi Special guifg=#eeeeee guibg=NONE gui=bold cterm=bold
hi Statement guifg=#eeeeee guibg=NONE gui=bold cterm=bold
hi Todo guifg=#f2d085 guibg=NONE gui=bold,reverse cterm=bold,reverse
hi Type guifg=#b2b2b2 guibg=NONE gui=NONE cterm=NONE
hi Underlined guifg=#eeeeee guibg=NONE gui=underline cterm=underline
hi CursorIM guifg=NONE guibg=fg gui=NONE cterm=NONE
hi ToolbarLine guifg=NONE guibg=#b2b2b2 gui=NONE cterm=NONE
hi ToolbarButton guifg=#eeeeee guibg=#4e4e4e gui=bold cterm=bold
hi IblScope guifg=#b2b2b2 guibg=NONE gui=NONE cterm=NONE
hi IblIndent guifg=#4e4e4e guibg=NONE gui=NONE cterm=NONE
hi IblWhitespace guifg=#4e4e4e guibg=NONE gui=NONE cterm=NONE
hi NormalFloat guifg=#84a7f2 guibg=#4e4e4e gui=NONE cterm=NONE
hi FloatBorder guifg=#84a7f2 guibg=#121212 gui=NONE cterm=NONE
hi CmpItemAbbr guifg=#eeeeee guibg=#121212 gui=NONE cterm=NONE
hi CmpItemMenu guifg=#eeeeee guibg=#121212 gui=NONE cterm=NONE
hi CmpItemAbbrMatch guifg=#eeeeee guibg=#121212 gui=NONE cterm=NONE
hi CmpItemAbbrMatchFuzzy guifg=#eeeeee guibg=#121212 gui=NONE cterm=NONE
if !s:italics
  hi Folded gui=NONE cterm=NONE
  hi Comment gui=NONE cterm=NONE
  hi Constant gui=NONE cterm=NONE
endif

if s:t_Co >= 256
  if get(g:, 'darktrial_transp_bg', 0)
    hi Normal ctermfg=255 ctermbg=NONE cterm=NONE
    hi Terminal ctermfg=255 ctermbg=NONE cterm=NONE
  else
    hi Normal ctermfg=255 ctermbg=233 cterm=NONE
    hi Terminal ctermfg=255 ctermbg=233 cterm=NONE
  endif
  hi ColorColumn ctermfg=fg ctermbg=130 cterm=NONE
  hi Conceal ctermfg=NONE ctermbg=NONE cterm=NONE
  hi Cursor ctermfg=NONE ctermbg=NONE cterm=NONE
  hi CursorColumn ctermfg=NONE ctermbg=236 cterm=NONE
  hi CursorLine ctermfg=NONE ctermbg=236 cterm=NONE
  hi CursorLineNr ctermfg=255 ctermbg=NONE cterm=bold
  hi DiffAdd ctermfg=41 ctermbg=NONE cterm=reverse
  hi DiffChange ctermfg=44 ctermbg=NONE cterm=reverse
  hi DiffDelete ctermfg=202 ctermbg=NONE cterm=reverse
  hi DiffText ctermfg=206 ctermbg=NONE cterm=bold,reverse
  hi Directory ctermfg=111 ctermbg=NONE cterm=NONE
  hi EndOfBuffer ctermfg=NONE ctermbg=NONE cterm=NONE
  hi ErrorMsg ctermfg=202 ctermbg=233 cterm=reverse
  hi FoldColumn ctermfg=239 ctermbg=233 cterm=NONE
  hi Folded ctermfg=249 ctermbg=239 cterm=italic
  hi IncSearch ctermfg=255 ctermbg=233 cterm=reverse
  hi LineNr ctermfg=239 ctermbg=233 cterm=NONE
  hi MatchParen ctermfg=233 ctermbg=222 cterm=NONE
  hi ModeMsg ctermfg=233 ctermbg=41 cterm=bold
  hi MoreMsg ctermfg=233 ctermbg=41 cterm=bold
  hi NonText ctermfg=249 ctermbg=NONE cterm=NONE
  hi Pmenu ctermfg=233 ctermbg=249 cterm=NONE
  hi PmenuSbar ctermfg=233 ctermbg=255 cterm=NONE
  hi PmenuSel ctermfg=NONE ctermbg=NONE cterm=reverse
  hi PmenuThumb ctermfg=NONE ctermbg=111 cterm=NONE
  hi Question ctermfg=233 ctermbg=41 cterm=NONE
  hi Search ctermfg=255 ctermbg=233 cterm=bold,reverse
  hi SignColumn ctermfg=239 ctermbg=233 cterm=NONE
  hi SpecialKey ctermfg=249 ctermbg=NONE cterm=NONE
  hi SpellBad ctermfg=NONE ctermbg=124 cterm=NONE
  hi SpellCap ctermfg=NONE ctermbg=111 cterm=NONE
  hi SpellLocal ctermfg=NONE ctermbg=206 cterm=NONE
  hi SpellRare ctermfg=NONE ctermbg=24 cterm=NONE
  hi StatusLine ctermfg=NONE ctermbg=111 cterm=bold
  hi StatusLineNC ctermfg=NONE ctermbg=239 cterm=NONE
  hi StatusLineTerm ctermfg=NONE ctermbg=41 cterm=bold
  hi StatusLineTermNC ctermfg=NONE ctermbg=239 cterm=NONE
  hi TabLine ctermfg=NONE ctermbg=239 cterm=bold
  hi TabLineFill ctermfg=NONE ctermbg=NONE cterm=NONE
  hi TabLineSel ctermfg=255 ctermbg=111 cterm=bold
  hi Title ctermfg=239 ctermbg=111 cterm=NONE
  hi VertSplit ctermfg=111 ctermbg=233 cterm=bold
  hi Visual ctermfg=NONE ctermbg=NONE cterm=reverse
  hi VisualNOS ctermfg=255 ctermbg=233 cterm=NONE
  hi WarningMsg ctermfg=233 ctermbg=222 cterm=NONE
  hi WildMenu ctermfg=255 ctermbg=233 cterm=NONE
  hi Comment ctermfg=249 ctermbg=NONE cterm=italic
  hi Constant ctermfg=255 ctermbg=NONE cterm=italic
  hi Error ctermfg=255 ctermbg=202 cterm=reverse
  hi Identifier ctermfg=111 ctermbg=NONE cterm=NONE
  hi Ignore ctermfg=41 ctermbg=NONE cterm=NONE
  hi PreProc ctermfg=255 ctermbg=NONE cterm=NONE
  hi Special ctermfg=255 ctermbg=NONE cterm=bold
  hi Statement ctermfg=255 ctermbg=NONE cterm=bold
  hi Todo ctermfg=222 ctermbg=NONE cterm=bold,reverse
  hi Type ctermfg=249 ctermbg=NONE cterm=NONE
  hi Underlined ctermfg=255 ctermbg=NONE cterm=underline
  hi CursorIM ctermfg=NONE ctermbg=fg cterm=NONE
  hi ToolbarLine ctermfg=NONE ctermbg=249 cterm=NONE
  hi ToolbarButton ctermfg=255 ctermbg=239 cterm=bold
  hi IblScope ctermfg=249 ctermbg=NONE cterm=NONE
  hi IblIndent ctermfg=239 ctermbg=NONE cterm=NONE
  hi IblWhitespace ctermfg=239 ctermbg=NONE cterm=NONE
  hi NormalFloat ctermfg=111 ctermbg=239 cterm=NONE
  hi FloatBorder ctermfg=111 ctermbg=233 cterm=NONE
  hi CmpItemAbbr ctermfg=255 ctermbg=233 cterm=NONE
  hi CmpItemMenu ctermfg=255 ctermbg=233 cterm=NONE
  hi CmpItemAbbrMatch ctermfg=255 ctermbg=233 cterm=NONE
  hi CmpItemAbbrMatchFuzzy ctermfg=255 ctermbg=233 cterm=NONE
  if !s:italics
    hi Folded cterm=NONE
    hi Comment cterm=NONE
    hi Constant cterm=NONE
  endif
  unlet s:t_Co s:italics
  finish
endif

if s:t_Co >= 8
  if get(g:, 'darktrial_transp_bg', 0)
    hi Normal ctermfg=LightGrey ctermbg=NONE cterm=NONE
    hi Terminal ctermfg=LightGrey ctermbg=NONE cterm=NONE
  else
    hi Normal ctermfg=LightGrey ctermbg=Black cterm=NONE
    hi Terminal ctermfg=LightGrey ctermbg=Black cterm=NONE
  endif
  hi ColorColumn ctermfg=fg ctermbg=LightYellow cterm=NONE
  hi Conceal ctermfg=NONE ctermbg=NONE cterm=NONE
  hi Cursor ctermfg=NONE ctermbg=NONE cterm=NONE
  hi CursorColumn ctermfg=NONE ctermbg=White cterm=NONE
  hi CursorLine ctermfg=NONE ctermbg=White cterm=NONE
  hi CursorLineNr ctermfg=LightGrey ctermbg=NONE cterm=bold
  hi DiffAdd ctermfg=DarkGreen ctermbg=NONE cterm=reverse
  hi DiffChange ctermfg=DarkCyan ctermbg=NONE cterm=reverse
  hi DiffDelete ctermfg=DarkRed ctermbg=NONE cterm=reverse
  hi DiffText ctermfg=DarkMagenta ctermbg=NONE cterm=bold,reverse
  hi Directory ctermfg=DarkBlue ctermbg=NONE cterm=NONE
  hi EndOfBuffer ctermfg=NONE ctermbg=NONE cterm=NONE
  hi ErrorMsg ctermfg=DarkRed ctermbg=Black cterm=reverse
  hi FoldColumn ctermfg=DarkGrey ctermbg=Black cterm=NONE
  hi Folded ctermfg=White ctermbg=DarkGrey cterm=italic
  hi IncSearch ctermfg=LightGrey ctermbg=Black cterm=reverse
  hi LineNr ctermfg=DarkGrey ctermbg=Black cterm=NONE
  hi MatchParen ctermfg=Black ctermbg=DarkYellow cterm=NONE
  hi ModeMsg ctermfg=Black ctermbg=DarkGreen cterm=bold
  hi MoreMsg ctermfg=Black ctermbg=DarkGreen cterm=bold
  hi NonText ctermfg=White ctermbg=NONE cterm=NONE
  hi Pmenu ctermfg=Black ctermbg=White cterm=NONE
  hi PmenuSbar ctermfg=Black ctermbg=LightGrey cterm=NONE
  hi PmenuSel ctermfg=NONE ctermbg=NONE cterm=reverse
  hi PmenuThumb ctermfg=NONE ctermbg=DarkBlue cterm=NONE
  hi Question ctermfg=Black ctermbg=DarkGreen cterm=NONE
  hi Search ctermfg=LightGrey ctermbg=Black cterm=bold,reverse
  hi SignColumn ctermfg=DarkGrey ctermbg=Black cterm=NONE
  hi SpecialKey ctermfg=White ctermbg=NONE cterm=NONE
  hi SpellBad ctermfg=NONE ctermbg=LightRed cterm=NONE
  hi SpellCap ctermfg=NONE ctermbg=DarkBlue cterm=NONE
  hi SpellLocal ctermfg=NONE ctermbg=DarkMagenta cterm=NONE
  hi SpellRare ctermfg=NONE ctermbg=LightCyan cterm=NONE
  hi StatusLine ctermfg=NONE ctermbg=DarkBlue cterm=bold
  hi StatusLineNC ctermfg=NONE ctermbg=DarkGrey cterm=NONE
  hi StatusLineTerm ctermfg=NONE ctermbg=DarkGreen cterm=bold
  hi StatusLineTermNC ctermfg=NONE ctermbg=DarkGrey cterm=NONE
  hi TabLine ctermfg=NONE ctermbg=DarkGrey cterm=bold
  hi TabLineFill ctermfg=NONE ctermbg=NONE cterm=NONE
  hi TabLineSel ctermfg=LightGrey ctermbg=DarkBlue cterm=bold
  hi Title ctermfg=DarkGrey ctermbg=DarkBlue cterm=NONE
  hi VertSplit ctermfg=DarkBlue ctermbg=Black cterm=bold
  hi Visual ctermfg=NONE ctermbg=NONE cterm=reverse
  hi VisualNOS ctermfg=LightGrey ctermbg=Black cterm=NONE
  hi WarningMsg ctermfg=Black ctermbg=DarkYellow cterm=NONE
  hi WildMenu ctermfg=LightGrey ctermbg=Black cterm=NONE
  hi Comment ctermfg=White ctermbg=NONE cterm=italic
  hi Constant ctermfg=LightGrey ctermbg=NONE cterm=italic
  hi Error ctermfg=LightGrey ctermbg=DarkRed cterm=reverse
  hi Identifier ctermfg=DarkBlue ctermbg=NONE cterm=NONE
  hi Ignore ctermfg=DarkGreen ctermbg=NONE cterm=NONE
  hi PreProc ctermfg=LightGrey ctermbg=NONE cterm=NONE
  hi Special ctermfg=LightGrey ctermbg=NONE cterm=bold
  hi Statement ctermfg=LightGrey ctermbg=NONE cterm=bold
  hi Todo ctermfg=DarkYellow ctermbg=NONE cterm=bold,reverse
  hi Type ctermfg=White ctermbg=NONE cterm=NONE
  hi Underlined ctermfg=LightGrey ctermbg=NONE cterm=underline
  hi CursorIM ctermfg=NONE ctermbg=fg cterm=NONE
  hi ToolbarLine ctermfg=NONE ctermbg=White cterm=NONE
  hi ToolbarButton ctermfg=LightGrey ctermbg=DarkGrey cterm=bold
  hi IblScope ctermfg=White ctermbg=NONE cterm=NONE
  hi IblIndent ctermfg=DarkGrey ctermbg=NONE cterm=NONE
  hi IblWhitespace ctermfg=DarkGrey ctermbg=NONE cterm=NONE
  hi NormalFloat ctermfg=DarkBlue ctermbg=DarkGrey cterm=NONE
  hi FloatBorder ctermfg=DarkBlue ctermbg=Black cterm=NONE
  hi CmpItemAbbr ctermfg=LightGrey ctermbg=Black cterm=NONE
  hi CmpItemMenu ctermfg=LightGrey ctermbg=Black cterm=NONE
  hi CmpItemAbbrMatch ctermfg=LightGrey ctermbg=Black cterm=NONE
  hi CmpItemAbbrMatchFuzzy ctermfg=LightGrey ctermbg=Black cterm=NONE
  if !s:italics
    hi Folded cterm=NONE
    hi Comment cterm=NONE
    hi Constant cterm=NONE
  endif
  unlet s:t_Co s:italics
  finish
endif

if s:t_Co >= 0
  hi Normal term=NONE
  hi ColorColumn term=reverse
  hi Conceal term=NONE
  hi Cursor term=NONE
  hi CursorColumn term=reverse
  hi CursorLine term=underline
  hi CursorLineNr term=bold,italic,reverse,underline
  hi DiffAdd term=reverse,underline
  hi DiffChange term=reverse,underline
  hi DiffDelete term=reverse,underline
  hi DiffText term=bold,reverse,underline
  hi Directory term=NONE
  hi EndOfBuffer term=NONE
  hi ErrorMsg term=bold,italic,reverse
  hi FoldColumn term=reverse
  hi Folded term=italic,reverse,underline
  hi IncSearch term=bold,italic,reverse
  hi LineNr term=reverse
  hi MatchParen term=bold,underline
  hi ModeMsg term=NONE
  hi MoreMsg term=NONE
  hi NonText term=NONE
  hi Pmenu term=reverse
  hi PmenuSbar term=NONE
  hi PmenuSel term=NONE
  hi PmenuThumb term=NONE
  hi PopupSelected term=reverse
  hi Question term=standout
  hi Search term=italic,underline
  hi SignColumn term=reverse
  hi SpecialKey term=bold
  hi SpellBad term=italic,underline
  hi SpellCap term=italic,underline
  hi SpellLocal term=italic,underline
  hi SpellRare term=italic,underline
  hi StatusLine term=bold,reverse
  hi StatusLineNC term=reverse
  hi TabLine term=italic,reverse,underline
  hi TabLineFill term=reverse,underline
  hi TabLineSel term=bold
  hi Title term=bold
  hi VertSplit term=reverse
  hi Visual term=reverse
  hi VisualNOS term=NONE
  hi WarningMsg term=standout
  hi WildMenu term=bold
  hi Comment term=italic
  hi Constant term=bold,italic
  hi Error term=reverse
  hi Identifier term=italic
  hi Ignore term=NONE
  hi PreProc term=italic
  hi Special term=bold,italic
  hi Statement term=bold
  hi Todo term=bold,underline
  hi Type term=bold
  hi Underlined term=underline
  hi CursorIM term=NONE
  hi ToolbarLine term=reverse
  hi ToolbarButton term=bold,reverse
  hi debugBreakpoint term=reverse
  hi debugPC term=reverse
  if !s:italics
    hi CursorLineNr term=bold,reverse,underline
    hi ErrorMsg term=bold,reverse
    hi Folded term=reverse,underline
    hi IncSearch term=bold,reverse
    hi Search term=underline
    hi SpellBad term=underline
    hi SpellCap term=underline
    hi SpellLocal term=underline
    hi SpellRare term=underline
    hi TabLine term=reverse,underline
    hi Comment term=NONE
    hi Constant term=bold
    hi Identifier term=NONE
    hi PreProc term=NONE
    hi Special term=bold
  endif
  unlet s:t_Co s:italics
  finish
endif

" Background: dark
" Color: black         rgb( 18,  18,  18)        ~         Black
" Color: red           rgb(255, 124,  59)        ~         DarkRed
" Color: green         rgb( 72, 213, 107)        ~         DarkGreen
" Color: yellow        rgb(242, 208, 133)        ~         DarkYellow
" Color: blue          rgb(132, 167, 242)        ~         DarkBlue
" Color: magenta       rgb(255, 102, 228)        ~         DarkMagenta
" Color: cyan          rgb( 57, 231, 216)        ~         DarkCyan
" Color: white         rgb(238, 238, 238)        ~         LightGrey
" Color: brightblack   rgb( 78,  78,  78)        ~         DarkGrey
" Color: brightred     rgb(181,  21,  48)        ~         LightRed
" Color: brightgreen   rgb(  7, 107,  71)        ~         LightGreen
" Color: brightyellow  rgb(147,  67,  5)         ~         LightYellow
" Color: brightblue    rgb( 16,  35, 122)        ~         LightBlue
" Color: brightmagenta rgb(151,   0, 183)        ~         LightMagenta
" Color: brightcyan    rgb(  0,  92, 125)        ~         LightCyan
" Color: brightwhite   rgb(178, 178, 178)        ~         White
" Color: highcol       rgb( 48,  48,  48)        ~         White
" Term colors: black red green yellow blue magenta cyan white
" Term colors: brightblack brightred brightgreen brightyellow
" Term colors: brightblue brightmagenta brightcyan brightwhite
" vim: et ts=8 sw=2 sts=2
