" Name:         Dark
" Description:  Template for dark colorscheme
" Author:       Myself <myself@somewhere.org>
" Maintainer:   Myself <myself@somewhere.org>
" Website:      https://me.org
" License:      Public domain
" Last Change:  2025 Mar 16

" Generated by Colortemplate v2.2.3

set background=dark

hi clear
let g:colors_name = 'dark'

let s:t_Co = has('gui_running') ? -1 : (&t_Co ?? 0)
let s:italics = has('gui_running') || (&t_ZH != '' && &t_ZH != '[7m' && !has('win32'))

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
  let g:terminal_ansi_colors = ['#394759', '#ff0000', '#00ff00', '#ffff00', '#0000ff', '#ff00ff', '#00ffff', '#ebebeb', '#d2d2d2', '#ff6400', '#64ff00', '#ffff64', '#0064ff', '#ff64ff', '#64ffff', '#e0e0ed']
endif
if get(g:, 'dark_transp_bg', 0) && !has('gui_running')
  hi Normal guifg=#ebebeb guibg=NONE gui=NONE cterm=NONE
  hi Terminal guifg=#ebebeb guibg=NONE gui=NONE cterm=NONE
else
  hi Normal guifg=#ebebeb guibg=#394759 gui=NONE cterm=NONE
  hi Terminal guifg=#ebebeb guibg=#394759 gui=NONE cterm=NONE
endif
hi ColorColumn guifg=fg guibg=#394759 gui=NONE cterm=NONE
hi Conceal guifg=NONE guibg=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi Cursor guifg=#ebebeb guibg=#394759 gui=NONE cterm=NONE
hi CursorColumn guifg=#ebebeb guibg=#394759 gui=NONE cterm=NONE
hi CursorLine guifg=#ebebeb guibg=#394759 gui=NONE cterm=NONE
hi CursorLineNr guifg=#ebebeb guibg=#394759 gui=NONE cterm=NONE
hi DiffAdd guifg=#ebebeb guibg=#394759 gui=reverse cterm=reverse
hi DiffChange guifg=#ebebeb guibg=#394759 gui=reverse cterm=reverse
hi DiffDelete guifg=#ebebeb guibg=#394759 gui=reverse cterm=reverse
hi DiffText guifg=#ebebeb guibg=#394759 gui=bold,reverse cterm=bold,reverse
hi Directory guifg=#ebebeb guibg=#394759 gui=NONE cterm=NONE
hi EndOfBuffer guifg=#ebebeb guibg=#394759 gui=NONE cterm=NONE
hi ErrorMsg guifg=#ebebeb guibg=#394759 gui=reverse cterm=reverse
hi FoldColumn guifg=#ebebeb guibg=#394759 gui=NONE cterm=NONE
hi Folded guifg=#ebebeb guibg=#394759 gui=italic cterm=italic
hi IncSearch guifg=#ebebeb guibg=#394759 gui=standout cterm=reverse
hi LineNr guifg=#ebebeb guibg=#394759 gui=NONE cterm=NONE
hi MatchParen guifg=#ebebeb guibg=#394759 gui=NONE cterm=NONE
hi ModeMsg guifg=#ebebeb guibg=#394759 gui=NONE cterm=NONE
hi MoreMsg guifg=#ebebeb guibg=#394759 gui=NONE cterm=NONE
hi NonText guifg=#ebebeb guibg=#394759 gui=NONE cterm=NONE
hi Pmenu guifg=#ebebeb guibg=#394759 gui=NONE cterm=NONE
hi PmenuSbar guifg=#ebebeb guibg=#394759 gui=NONE cterm=NONE
hi PmenuSel guifg=#ebebeb guibg=#394759 gui=reverse cterm=reverse
hi PmenuThumb guifg=#ebebeb guibg=#394759 gui=NONE cterm=NONE
hi Question guifg=#ebebeb guibg=#394759 gui=NONE cterm=NONE
hi Search guifg=#ebebeb guibg=#394759 gui=NONE cterm=NONE
hi SignColumn guifg=#ebebeb guibg=#394759 gui=NONE cterm=NONE
hi SpecialKey guifg=#ebebeb guibg=#394759 gui=NONE cterm=NONE
hi SpellBad guifg=#ebebeb guibg=#394759 guisp=#ff0000 gui=NONE cterm=NONE
hi SpellCap guifg=#ebebeb guibg=#394759 guisp=#0000ff gui=NONE cterm=NONE
hi SpellLocal guifg=#ebebeb guibg=#394759 guisp=#ff00ff gui=NONE cterm=NONE
hi SpellRare guifg=#ebebeb guibg=#394759 guisp=#00ffff gui=reverse cterm=reverse
hi StatusLine guifg=#ebebeb guibg=#394759 gui=NONE cterm=NONE
hi StatusLineNC guifg=#ebebeb guibg=#394759 gui=NONE cterm=NONE
hi TabLine guifg=#ebebeb guibg=#394759 gui=NONE cterm=NONE
hi TabLineFill guifg=#ebebeb guibg=#394759 gui=NONE cterm=NONE
hi TabLineSel guifg=#ebebeb guibg=#394759 gui=NONE cterm=NONE
hi Title guifg=#ebebeb guibg=#394759 gui=NONE cterm=NONE
hi VertSplit guifg=#ebebeb guibg=#394759 gui=NONE cterm=NONE
hi Visual guifg=#ebebeb guibg=#394759 gui=NONE cterm=NONE
hi VisualNOS guifg=#ebebeb guibg=#394759 gui=NONE cterm=NONE
hi WarningMsg guifg=#ebebeb guibg=#394759 gui=NONE cterm=NONE
hi WildMenu guifg=#ebebeb guibg=#394759 gui=NONE cterm=NONE
hi Comment guifg=#ebebeb guibg=NONE gui=italic cterm=italic
hi Constant guifg=#ebebeb guibg=NONE gui=NONE cterm=NONE
hi Error guifg=#ebebeb guibg=#394759 gui=reverse cterm=reverse
hi Identifier guifg=#ebebeb guibg=NONE gui=NONE cterm=NONE
hi Ignore guifg=#ebebeb guibg=NONE gui=NONE cterm=NONE
hi PreProc guifg=#ebebeb guibg=NONE gui=NONE cterm=NONE
hi Special guifg=#ebebeb guibg=NONE gui=NONE cterm=NONE
hi Statement guifg=#ebebeb guibg=NONE gui=NONE cterm=NONE
hi Todo guifg=#ebebeb guibg=NONE gui=NONE cterm=NONE
hi Type guifg=#ebebeb guibg=NONE gui=NONE cterm=NONE
hi Underlined guifg=#ebebeb guibg=NONE gui=NONE cterm=NONE
hi CursorIM guifg=NONE guibg=fg gui=NONE cterm=NONE
hi ToolbarLine guifg=NONE guibg=#394759 gui=NONE cterm=NONE
hi ToolbarButton guifg=#ebebeb guibg=#394759 gui=bold cterm=bold
if !s:italics
  hi Folded gui=NONE cterm=NONE
  hi Comment gui=NONE cterm=NONE
endif

if s:t_Co >= 256
  if get(g:, 'dark_transp_bg', 0)
    hi Normal ctermfg=255 ctermbg=NONE cterm=NONE
    hi Terminal ctermfg=255 ctermbg=NONE cterm=NONE
  else
    hi Normal ctermfg=255 ctermbg=238 cterm=NONE
    hi Terminal ctermfg=255 ctermbg=238 cterm=NONE
  endif
  hi ColorColumn ctermfg=fg ctermbg=238 cterm=NONE
  hi Conceal ctermfg=NONE ctermbg=NONE cterm=NONE
  hi Cursor ctermfg=255 ctermbg=238 cterm=NONE
  hi CursorColumn ctermfg=255 ctermbg=238 cterm=NONE
  hi CursorLine ctermfg=255 ctermbg=238 cterm=NONE
  hi CursorLineNr ctermfg=255 ctermbg=238 cterm=NONE
  hi DiffAdd ctermfg=255 ctermbg=238 cterm=reverse
  hi DiffChange ctermfg=255 ctermbg=238 cterm=reverse
  hi DiffDelete ctermfg=255 ctermbg=238 cterm=reverse
  hi DiffText ctermfg=255 ctermbg=238 cterm=bold,reverse
  hi Directory ctermfg=255 ctermbg=238 cterm=NONE
  hi EndOfBuffer ctermfg=255 ctermbg=238 cterm=NONE
  hi ErrorMsg ctermfg=255 ctermbg=238 cterm=reverse
  hi FoldColumn ctermfg=255 ctermbg=238 cterm=NONE
  hi Folded ctermfg=255 ctermbg=238 cterm=italic
  hi IncSearch ctermfg=255 ctermbg=238 cterm=reverse
  hi LineNr ctermfg=255 ctermbg=238 cterm=NONE
  hi MatchParen ctermfg=255 ctermbg=238 cterm=NONE
  hi ModeMsg ctermfg=255 ctermbg=238 cterm=NONE
  hi MoreMsg ctermfg=255 ctermbg=238 cterm=NONE
  hi NonText ctermfg=255 ctermbg=238 cterm=NONE
  hi Pmenu ctermfg=255 ctermbg=238 cterm=NONE
  hi PmenuSbar ctermfg=255 ctermbg=238 cterm=NONE
  hi PmenuSel ctermfg=255 ctermbg=238 cterm=reverse
  hi PmenuThumb ctermfg=255 ctermbg=238 cterm=NONE
  hi Question ctermfg=255 ctermbg=238 cterm=NONE
  hi Search ctermfg=255 ctermbg=238 cterm=NONE
  hi SignColumn ctermfg=255 ctermbg=238 cterm=NONE
  hi SpecialKey ctermfg=255 ctermbg=238 cterm=NONE
  hi SpellBad ctermfg=255 ctermbg=238 cterm=NONE
  hi SpellCap ctermfg=255 ctermbg=238 cterm=NONE
  hi SpellLocal ctermfg=255 ctermbg=238 cterm=NONE
  hi SpellRare ctermfg=255 ctermbg=238 cterm=reverse
  hi StatusLine ctermfg=255 ctermbg=238 cterm=NONE
  hi StatusLineNC ctermfg=255 ctermbg=238 cterm=NONE
  hi TabLine ctermfg=255 ctermbg=238 cterm=NONE
  hi TabLineFill ctermfg=255 ctermbg=238 cterm=NONE
  hi TabLineSel ctermfg=255 ctermbg=238 cterm=NONE
  hi Title ctermfg=255 ctermbg=238 cterm=NONE
  hi VertSplit ctermfg=255 ctermbg=238 cterm=NONE
  hi Visual ctermfg=255 ctermbg=238 cterm=NONE
  hi VisualNOS ctermfg=255 ctermbg=238 cterm=NONE
  hi WarningMsg ctermfg=255 ctermbg=238 cterm=NONE
  hi WildMenu ctermfg=255 ctermbg=238 cterm=NONE
  hi Comment ctermfg=255 ctermbg=NONE cterm=italic
  hi Constant ctermfg=255 ctermbg=NONE cterm=NONE
  hi Error ctermfg=255 ctermbg=238 cterm=reverse
  hi Identifier ctermfg=255 ctermbg=NONE cterm=NONE
  hi Ignore ctermfg=255 ctermbg=NONE cterm=NONE
  hi PreProc ctermfg=255 ctermbg=NONE cterm=NONE
  hi Special ctermfg=255 ctermbg=NONE cterm=NONE
  hi Statement ctermfg=255 ctermbg=NONE cterm=NONE
  hi Todo ctermfg=255 ctermbg=NONE cterm=NONE
  hi Type ctermfg=255 ctermbg=NONE cterm=NONE
  hi Underlined ctermfg=255 ctermbg=NONE cterm=NONE
  hi CursorIM ctermfg=NONE ctermbg=fg cterm=NONE
  hi ToolbarLine ctermfg=NONE ctermbg=238 cterm=NONE
  hi ToolbarButton ctermfg=255 ctermbg=238 cterm=bold
  if !s:italics
    hi Folded cterm=NONE
    hi Comment cterm=NONE
  endif
  unlet s:t_Co s:italics
  finish
endif

if s:t_Co >= 8
  if get(g:, 'dark_transp_bg', 0)
    hi Normal ctermfg=LightGrey ctermbg=NONE cterm=NONE
    hi Terminal ctermfg=LightGrey ctermbg=NONE cterm=NONE
  else
    hi Normal ctermfg=LightGrey ctermbg=Black cterm=NONE
    hi Terminal ctermfg=LightGrey ctermbg=Black cterm=NONE
  endif
  hi ColorColumn ctermfg=fg ctermbg=Black cterm=NONE
  hi Conceal ctermfg=NONE ctermbg=NONE cterm=NONE
  hi Cursor ctermfg=LightGrey ctermbg=Black cterm=NONE
  hi CursorColumn ctermfg=LightGrey ctermbg=Black cterm=NONE
  hi CursorLine ctermfg=LightGrey ctermbg=Black cterm=NONE
  hi CursorLineNr ctermfg=LightGrey ctermbg=Black cterm=NONE
  hi DiffAdd ctermfg=LightGrey ctermbg=Black cterm=reverse
  hi DiffChange ctermfg=LightGrey ctermbg=Black cterm=reverse
  hi DiffDelete ctermfg=LightGrey ctermbg=Black cterm=reverse
  hi DiffText ctermfg=LightGrey ctermbg=Black cterm=bold,reverse
  hi Directory ctermfg=LightGrey ctermbg=Black cterm=NONE
  hi EndOfBuffer ctermfg=LightGrey ctermbg=Black cterm=NONE
  hi ErrorMsg ctermfg=LightGrey ctermbg=Black cterm=reverse
  hi FoldColumn ctermfg=LightGrey ctermbg=Black cterm=NONE
  hi Folded ctermfg=LightGrey ctermbg=Black cterm=italic
  hi IncSearch ctermfg=LightGrey ctermbg=Black cterm=reverse
  hi LineNr ctermfg=LightGrey ctermbg=Black cterm=NONE
  hi MatchParen ctermfg=LightGrey ctermbg=Black cterm=NONE
  hi ModeMsg ctermfg=LightGrey ctermbg=Black cterm=NONE
  hi MoreMsg ctermfg=LightGrey ctermbg=Black cterm=NONE
  hi NonText ctermfg=LightGrey ctermbg=Black cterm=NONE
  hi Pmenu ctermfg=LightGrey ctermbg=Black cterm=NONE
  hi PmenuSbar ctermfg=LightGrey ctermbg=Black cterm=NONE
  hi PmenuSel ctermfg=LightGrey ctermbg=Black cterm=reverse
  hi PmenuThumb ctermfg=LightGrey ctermbg=Black cterm=NONE
  hi Question ctermfg=LightGrey ctermbg=Black cterm=NONE
  hi Search ctermfg=LightGrey ctermbg=Black cterm=NONE
  hi SignColumn ctermfg=LightGrey ctermbg=Black cterm=NONE
  hi SpecialKey ctermfg=LightGrey ctermbg=Black cterm=NONE
  hi SpellBad ctermfg=LightGrey ctermbg=Black cterm=NONE
  hi SpellCap ctermfg=LightGrey ctermbg=Black cterm=NONE
  hi SpellLocal ctermfg=LightGrey ctermbg=Black cterm=NONE
  hi SpellRare ctermfg=LightGrey ctermbg=Black cterm=reverse
  hi StatusLine ctermfg=LightGrey ctermbg=Black cterm=NONE
  hi StatusLineNC ctermfg=LightGrey ctermbg=Black cterm=NONE
  hi TabLine ctermfg=LightGrey ctermbg=Black cterm=NONE
  hi TabLineFill ctermfg=LightGrey ctermbg=Black cterm=NONE
  hi TabLineSel ctermfg=LightGrey ctermbg=Black cterm=NONE
  hi Title ctermfg=LightGrey ctermbg=Black cterm=NONE
  hi VertSplit ctermfg=LightGrey ctermbg=Black cterm=NONE
  hi Visual ctermfg=LightGrey ctermbg=Black cterm=NONE
  hi VisualNOS ctermfg=LightGrey ctermbg=Black cterm=NONE
  hi WarningMsg ctermfg=LightGrey ctermbg=Black cterm=NONE
  hi WildMenu ctermfg=LightGrey ctermbg=Black cterm=NONE
  hi Comment ctermfg=LightGrey ctermbg=NONE cterm=italic
  hi Constant ctermfg=LightGrey ctermbg=NONE cterm=NONE
  hi Error ctermfg=LightGrey ctermbg=Black cterm=reverse
  hi Identifier ctermfg=LightGrey ctermbg=NONE cterm=NONE
  hi Ignore ctermfg=LightGrey ctermbg=NONE cterm=NONE
  hi PreProc ctermfg=LightGrey ctermbg=NONE cterm=NONE
  hi Special ctermfg=LightGrey ctermbg=NONE cterm=NONE
  hi Statement ctermfg=LightGrey ctermbg=NONE cterm=NONE
  hi Todo ctermfg=LightGrey ctermbg=NONE cterm=NONE
  hi Type ctermfg=LightGrey ctermbg=NONE cterm=NONE
  hi Underlined ctermfg=LightGrey ctermbg=NONE cterm=NONE
  hi CursorIM ctermfg=NONE ctermbg=fg cterm=NONE
  hi ToolbarLine ctermfg=NONE ctermbg=Black cterm=NONE
  hi ToolbarButton ctermfg=LightGrey ctermbg=Black cterm=bold
  if !s:italics
    hi Folded cterm=NONE
    hi Comment cterm=NONE
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
" Color: black         rgb( 57,  71,  89)        ~         Black
" Color: red           rgb(255,   0,   0)        ~         DarkRed
" Color: green         rgb(  0, 255,   0)        ~         DarkGreen
" Color: yellow        rgb(255, 255,   0)        ~         DarkYellow
" Color: blue          rgb(  0,   0, 255)        ~         DarkBlue
" Color: magenta       rgb(255,   0, 255)        ~         DarkMagenta
" Color: cyan          rgb(  0, 255, 255)        ~         DarkCyan
" Color: white         rgb(235, 235, 235)        ~         LightGrey
" Color: brightblack   rgb(210, 210, 210)        ~         DarkGrey
" Color: brightred     rgb(255, 100,   0)        ~         LightRed
" Color: brightgreen   rgb(100, 255,   0)        ~         LightGreen
" Color: brightyellow  rgb(255, 255, 100)        ~         LightYellow
" Color: brightblue    rgb(  0, 100, 255)        ~         LightBlue
" Color: brightmagenta rgb(255, 100, 255)        ~         LightMagenta
" Color: brightcyan    rgb(100, 255, 255)        ~         LightCyan
" Color: brightwhite   #e0e0ed                  231        White
" Term colors: black red green yellow blue magenta cyan white
" Term colors: brightblack brightred brightgreen brightyellow
" Term colors: brightblue brightmagenta brightcyan brightwhite
" vim: et ts=8 sw=2 sts=2
