" Name:         Light
" Description:  Template for a light colorscheme
" Author:       Myself <myself@somewhere.org>
" Maintainer:   Myself <myself@somewhere.org>
" Website:      https://me.org
" License:      Public domain
" Last Change:  2025 Mar 16

" Generated by Colortemplate v2.2.3

set background=light

hi clear
let g:colors_name = 'light'

let s:t_Co = has('gui_running') ? -1 : (&t_Co ?? 0)
let s:italics = has('gui_running') || (&t_ZH != '' && &t_ZH != '[7m' && !has('win32'))

hi! link Added diffAdded
hi! link Boolean Constant
hi! link Changed diffChanged
hi! link Character Constant
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
hi! link PmenuMatchSel PmenuMatchSel
hi! link PopupNotification WarningMsg
hi! link PopupSelected PmenuSel
hi! link PreCondit PreProc
hi! link QuickFixLine Search
hi! link Removed diffRemoved
hi! link Repeat Statement
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
  let g:terminal_ansi_colors = ['#53585f', '#ff0000', '#00ff00', '#ffff00', '#0000ff', '#ff00ff', '#00ffff', '#ebebeb', '#d2d2d2', '#ff6400', '#64ff00', '#ffff64', '#0064ff', '#ff64ff', '#64ffff', '#ffffff']
endif
if get(g:, 'light_transp_bg', 0) && !has('gui_running')
  hi Normal guifg=#53585f guibg=NONE gui=NONE cterm=NONE
  hi Terminal guifg=#53585f guibg=NONE gui=NONE cterm=NONE
else
  hi Normal guifg=#53585f guibg=#ebebeb gui=NONE cterm=NONE
  hi Terminal guifg=#53585f guibg=#ebebeb gui=NONE cterm=NONE
endif
hi ColorColumn guifg=fg guibg=#ebebeb gui=NONE cterm=NONE
hi Conceal guifg=NONE guibg=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi Cursor guifg=#53585f guibg=#ebebeb gui=NONE cterm=NONE
hi CursorColumn guifg=#53585f guibg=#ebebeb gui=NONE cterm=NONE
hi CursorLine guifg=#53585f guibg=#ebebeb gui=NONE cterm=NONE
hi CursorLineNr guifg=#53585f guibg=#ebebeb gui=NONE cterm=NONE
hi DiffAdd guifg=#53585f guibg=#ebebeb gui=reverse cterm=reverse
hi DiffChange guifg=#53585f guibg=#ebebeb gui=reverse cterm=reverse
hi DiffDelete guifg=#53585f guibg=#ebebeb gui=reverse cterm=reverse
hi DiffText guifg=#53585f guibg=#ebebeb gui=bold,reverse cterm=bold,reverse
hi Directory guifg=#53585f guibg=#ebebeb gui=NONE cterm=NONE
hi EndOfBuffer guifg=#53585f guibg=#ebebeb gui=NONE cterm=NONE
hi ErrorMsg guifg=#53585f guibg=#ebebeb gui=reverse cterm=reverse
hi FoldColumn guifg=#53585f guibg=#ebebeb gui=NONE cterm=NONE
hi Folded guifg=#53585f guibg=#ebebeb gui=italic cterm=italic
hi IncSearch guifg=#53585f guibg=#ebebeb gui=standout cterm=reverse
hi LineNr guifg=#53585f guibg=#ebebeb gui=NONE cterm=NONE
hi MatchParen guifg=#53585f guibg=#ebebeb gui=NONE cterm=NONE
hi ModeMsg guifg=#53585f guibg=#ebebeb gui=NONE cterm=NONE
hi MoreMsg guifg=#53585f guibg=#ebebeb gui=NONE cterm=NONE
hi NonText guifg=#53585f guibg=#ebebeb gui=NONE cterm=NONE
hi Pmenu guifg=#53585f guibg=#ebebeb gui=NONE cterm=NONE
hi PmenuSbar guifg=#53585f guibg=#ebebeb gui=NONE cterm=NONE
hi PmenuSel guifg=#53585f guibg=#ebebeb gui=reverse cterm=reverse
hi PmenuThumb guifg=#53585f guibg=#ebebeb gui=NONE cterm=NONE
hi Question guifg=#53585f guibg=#ebebeb gui=NONE cterm=NONE
hi Search guifg=#53585f guibg=#ebebeb gui=NONE cterm=NONE
hi SignColumn guifg=#53585f guibg=#ebebeb gui=NONE cterm=NONE
hi SpecialKey guifg=#53585f guibg=#ebebeb gui=NONE cterm=NONE
hi SpellBad guifg=#53585f guibg=#ebebeb guisp=#ff0000 gui=NONE cterm=NONE
hi SpellCap guifg=#53585f guibg=#ebebeb guisp=#0000ff gui=NONE cterm=NONE
hi SpellLocal guifg=#53585f guibg=#ebebeb guisp=#ff00ff gui=NONE cterm=NONE
hi SpellRare guifg=#53585f guibg=#ebebeb guisp=#00ffff gui=reverse cterm=reverse
hi StatusLine guifg=#53585f guibg=#ebebeb gui=NONE cterm=NONE
hi StatusLineNC guifg=#53585f guibg=#ebebeb gui=NONE cterm=NONE
hi TabLine guifg=#53585f guibg=#ebebeb gui=NONE cterm=NONE
hi TabLineFill guifg=#53585f guibg=#ebebeb gui=NONE cterm=NONE
hi TabLineSel guifg=#53585f guibg=#ebebeb gui=NONE cterm=NONE
hi Title guifg=#53585f guibg=#ebebeb gui=NONE cterm=NONE
hi VertSplit guifg=#53585f guibg=#ebebeb gui=NONE cterm=NONE
hi Visual guifg=#53585f guibg=#ebebeb gui=NONE cterm=NONE
hi VisualNOS guifg=#53585f guibg=#ebebeb gui=NONE cterm=NONE
hi WarningMsg guifg=#53585f guibg=#ebebeb gui=NONE cterm=NONE
hi WildMenu guifg=#53585f guibg=#ebebeb gui=NONE cterm=NONE
hi Comment guifg=#53585f guibg=NONE gui=italic cterm=italic
hi Constant guifg=#53585f guibg=NONE gui=NONE cterm=NONE
hi Error guifg=#53585f guibg=#ebebeb gui=reverse cterm=reverse
hi Identifier guifg=#53585f guibg=NONE gui=NONE cterm=NONE
hi Ignore guifg=#53585f guibg=NONE gui=NONE cterm=NONE
hi PreProc guifg=#53585f guibg=NONE gui=NONE cterm=NONE
hi Special guifg=#53585f guibg=NONE gui=NONE cterm=NONE
hi Statement guifg=#53585f guibg=NONE gui=NONE cterm=NONE
hi Todo guifg=#53585f guibg=NONE gui=NONE cterm=NONE
hi Type guifg=#53585f guibg=NONE gui=NONE cterm=NONE
hi Underlined guifg=#53585f guibg=NONE gui=NONE cterm=NONE
hi CursorIM guifg=NONE guibg=fg gui=NONE cterm=NONE
hi ToolbarLine guifg=NONE guibg=#ebebeb gui=NONE cterm=NONE
hi ToolbarButton guifg=#53585f guibg=#ebebeb gui=bold cterm=bold
if !s:italics
  hi Folded gui=NONE cterm=NONE
  hi Comment gui=NONE cterm=NONE
endif

if s:t_Co >= 256
  if get(g:, 'light_transp_bg', 0)
    hi Normal ctermfg=240 ctermbg=NONE cterm=NONE
    hi Terminal ctermfg=240 ctermbg=NONE cterm=NONE
  else
    hi Normal ctermfg=240 ctermbg=255 cterm=NONE
    hi Terminal ctermfg=240 ctermbg=255 cterm=NONE
  endif
  hi ColorColumn ctermfg=fg ctermbg=255 cterm=NONE
  hi Conceal ctermfg=NONE ctermbg=NONE cterm=NONE
  hi Cursor ctermfg=240 ctermbg=255 cterm=NONE
  hi CursorColumn ctermfg=240 ctermbg=255 cterm=NONE
  hi CursorLine ctermfg=240 ctermbg=255 cterm=NONE
  hi CursorLineNr ctermfg=240 ctermbg=255 cterm=NONE
  hi DiffAdd ctermfg=240 ctermbg=255 cterm=reverse
  hi DiffChange ctermfg=240 ctermbg=255 cterm=reverse
  hi DiffDelete ctermfg=240 ctermbg=255 cterm=reverse
  hi DiffText ctermfg=240 ctermbg=255 cterm=bold,reverse
  hi Directory ctermfg=240 ctermbg=255 cterm=NONE
  hi EndOfBuffer ctermfg=240 ctermbg=255 cterm=NONE
  hi ErrorMsg ctermfg=240 ctermbg=255 cterm=reverse
  hi FoldColumn ctermfg=240 ctermbg=255 cterm=NONE
  hi Folded ctermfg=240 ctermbg=255 cterm=italic
  hi IncSearch ctermfg=240 ctermbg=255 cterm=reverse
  hi LineNr ctermfg=240 ctermbg=255 cterm=NONE
  hi MatchParen ctermfg=240 ctermbg=255 cterm=NONE
  hi ModeMsg ctermfg=240 ctermbg=255 cterm=NONE
  hi MoreMsg ctermfg=240 ctermbg=255 cterm=NONE
  hi NonText ctermfg=240 ctermbg=255 cterm=NONE
  hi Pmenu ctermfg=240 ctermbg=255 cterm=NONE
  hi PmenuSbar ctermfg=240 ctermbg=255 cterm=NONE
  hi PmenuSel ctermfg=240 ctermbg=255 cterm=reverse
  hi PmenuThumb ctermfg=240 ctermbg=255 cterm=NONE
  hi Question ctermfg=240 ctermbg=255 cterm=NONE
  hi Search ctermfg=240 ctermbg=255 cterm=NONE
  hi SignColumn ctermfg=240 ctermbg=255 cterm=NONE
  hi SpecialKey ctermfg=240 ctermbg=255 cterm=NONE
  hi SpellBad ctermfg=240 ctermbg=255 cterm=NONE
  hi SpellCap ctermfg=240 ctermbg=255 cterm=NONE
  hi SpellLocal ctermfg=240 ctermbg=255 cterm=NONE
  hi SpellRare ctermfg=240 ctermbg=255 cterm=reverse
  hi StatusLine ctermfg=240 ctermbg=255 cterm=NONE
  hi StatusLineNC ctermfg=240 ctermbg=255 cterm=NONE
  hi TabLine ctermfg=240 ctermbg=255 cterm=NONE
  hi TabLineFill ctermfg=240 ctermbg=255 cterm=NONE
  hi TabLineSel ctermfg=240 ctermbg=255 cterm=NONE
  hi Title ctermfg=240 ctermbg=255 cterm=NONE
  hi VertSplit ctermfg=240 ctermbg=255 cterm=NONE
  hi Visual ctermfg=240 ctermbg=255 cterm=NONE
  hi VisualNOS ctermfg=240 ctermbg=255 cterm=NONE
  hi WarningMsg ctermfg=240 ctermbg=255 cterm=NONE
  hi WildMenu ctermfg=240 ctermbg=255 cterm=NONE
  hi Comment ctermfg=240 ctermbg=NONE cterm=italic
  hi Constant ctermfg=240 ctermbg=NONE cterm=NONE
  hi Error ctermfg=240 ctermbg=255 cterm=reverse
  hi Identifier ctermfg=240 ctermbg=NONE cterm=NONE
  hi Ignore ctermfg=240 ctermbg=NONE cterm=NONE
  hi PreProc ctermfg=240 ctermbg=NONE cterm=NONE
  hi Special ctermfg=240 ctermbg=NONE cterm=NONE
  hi Statement ctermfg=240 ctermbg=NONE cterm=NONE
  hi Todo ctermfg=240 ctermbg=NONE cterm=NONE
  hi Type ctermfg=240 ctermbg=NONE cterm=NONE
  hi Underlined ctermfg=240 ctermbg=NONE cterm=NONE
  hi CursorIM ctermfg=NONE ctermbg=fg cterm=NONE
  hi ToolbarLine ctermfg=NONE ctermbg=255 cterm=NONE
  hi ToolbarButton ctermfg=240 ctermbg=255 cterm=bold
  if !s:italics
    hi Folded cterm=NONE
    hi Comment cterm=NONE
  endif
  unlet s:t_Co s:italics
  finish
endif

if s:t_Co >= 8
  if get(g:, 'light_transp_bg', 0)
    hi Normal ctermfg=Black ctermbg=NONE cterm=NONE
    hi Terminal ctermfg=Black ctermbg=NONE cterm=NONE
  else
    hi Normal ctermfg=Black ctermbg=LightGrey cterm=NONE
    hi Terminal ctermfg=Black ctermbg=LightGrey cterm=NONE
  endif
  hi ColorColumn ctermfg=fg ctermbg=LightGrey cterm=NONE
  hi Conceal ctermfg=NONE ctermbg=NONE cterm=NONE
  hi Cursor ctermfg=Black ctermbg=LightGrey cterm=NONE
  hi CursorColumn ctermfg=Black ctermbg=LightGrey cterm=NONE
  hi CursorLine ctermfg=Black ctermbg=LightGrey cterm=NONE
  hi CursorLineNr ctermfg=Black ctermbg=LightGrey cterm=NONE
  hi DiffAdd ctermfg=Black ctermbg=LightGrey cterm=reverse
  hi DiffChange ctermfg=Black ctermbg=LightGrey cterm=reverse
  hi DiffDelete ctermfg=Black ctermbg=LightGrey cterm=reverse
  hi DiffText ctermfg=Black ctermbg=LightGrey cterm=bold,reverse
  hi Directory ctermfg=Black ctermbg=LightGrey cterm=NONE
  hi EndOfBuffer ctermfg=Black ctermbg=LightGrey cterm=NONE
  hi ErrorMsg ctermfg=Black ctermbg=LightGrey cterm=reverse
  hi FoldColumn ctermfg=Black ctermbg=LightGrey cterm=NONE
  hi Folded ctermfg=Black ctermbg=LightGrey cterm=italic
  hi IncSearch ctermfg=Black ctermbg=LightGrey cterm=reverse
  hi LineNr ctermfg=Black ctermbg=LightGrey cterm=NONE
  hi MatchParen ctermfg=Black ctermbg=LightGrey cterm=NONE
  hi ModeMsg ctermfg=Black ctermbg=LightGrey cterm=NONE
  hi MoreMsg ctermfg=Black ctermbg=LightGrey cterm=NONE
  hi NonText ctermfg=Black ctermbg=LightGrey cterm=NONE
  hi Pmenu ctermfg=Black ctermbg=LightGrey cterm=NONE
  hi PmenuSbar ctermfg=Black ctermbg=LightGrey cterm=NONE
  hi PmenuSel ctermfg=Black ctermbg=LightGrey cterm=reverse
  hi PmenuThumb ctermfg=Black ctermbg=LightGrey cterm=NONE
  hi Question ctermfg=Black ctermbg=LightGrey cterm=NONE
  hi Search ctermfg=Black ctermbg=LightGrey cterm=NONE
  hi SignColumn ctermfg=Black ctermbg=LightGrey cterm=NONE
  hi SpecialKey ctermfg=Black ctermbg=LightGrey cterm=NONE
  hi SpellBad ctermfg=Black ctermbg=LightGrey cterm=NONE
  hi SpellCap ctermfg=Black ctermbg=LightGrey cterm=NONE
  hi SpellLocal ctermfg=Black ctermbg=LightGrey cterm=NONE
  hi SpellRare ctermfg=Black ctermbg=LightGrey cterm=reverse
  hi StatusLine ctermfg=Black ctermbg=LightGrey cterm=NONE
  hi StatusLineNC ctermfg=Black ctermbg=LightGrey cterm=NONE
  hi TabLine ctermfg=Black ctermbg=LightGrey cterm=NONE
  hi TabLineFill ctermfg=Black ctermbg=LightGrey cterm=NONE
  hi TabLineSel ctermfg=Black ctermbg=LightGrey cterm=NONE
  hi Title ctermfg=Black ctermbg=LightGrey cterm=NONE
  hi VertSplit ctermfg=Black ctermbg=LightGrey cterm=NONE
  hi Visual ctermfg=Black ctermbg=LightGrey cterm=NONE
  hi VisualNOS ctermfg=Black ctermbg=LightGrey cterm=NONE
  hi WarningMsg ctermfg=Black ctermbg=LightGrey cterm=NONE
  hi WildMenu ctermfg=Black ctermbg=LightGrey cterm=NONE
  hi Comment ctermfg=Black ctermbg=NONE cterm=italic
  hi Constant ctermfg=Black ctermbg=NONE cterm=NONE
  hi Error ctermfg=Black ctermbg=LightGrey cterm=reverse
  hi Identifier ctermfg=Black ctermbg=NONE cterm=NONE
  hi Ignore ctermfg=Black ctermbg=NONE cterm=NONE
  hi PreProc ctermfg=Black ctermbg=NONE cterm=NONE
  hi Special ctermfg=Black ctermbg=NONE cterm=NONE
  hi Statement ctermfg=Black ctermbg=NONE cterm=NONE
  hi Todo ctermfg=Black ctermbg=NONE cterm=NONE
  hi Type ctermfg=Black ctermbg=NONE cterm=NONE
  hi Underlined ctermfg=Black ctermbg=NONE cterm=NONE
  hi CursorIM ctermfg=NONE ctermbg=fg cterm=NONE
  hi ToolbarLine ctermfg=NONE ctermbg=LightGrey cterm=NONE
  hi ToolbarButton ctermfg=Black ctermbg=LightGrey cterm=bold
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

" Background: light
" Color: black         rgb( 83,  88,  95)        ~         Black
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
" Color: brightwhite   #ffffff                  231        White
" Term colors: black red green yellow blue magenta cyan white
" Term colors: brightblack brightred brightgreen brightyellow
" Term colors: brightblue brightmagenta brightcyan brightwhite
" vim: et ts=8 sw=2 sts=2
