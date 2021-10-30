highlight clear
" This fucks up everything
"set background=dark
if exists("syntax_on")
    syntax reset
endif

let g:colors_name = "dark_trial"
" Grey7
let g:terminal_color_0  = "#121212"
let g:terminal_color_1  = "#ff7c59"
let g:terminal_color_2  = "#48d56b"
let g:terminal_color_3  = "#ffb94c"
let g:terminal_color_4  = "#84a7f2"
let g:terminal_color_5  = "#ff66e4"
let g:terminal_color_6  = "#39e7d8"
" Grey93
let g:terminal_color_7  = "#eeeeee"
" Grey30
let g:terminal_color_8  = "#4e4e4e"
let g:terminal_color_9  = "#b51530"
let g:terminal_color_10 = "#076b47"
let g:terminal_color_11 = "#934305"
let g:terminal_color_12 = "#10237a"
let g:terminal_color_13 = "#9700b7"
let g:terminal_color_14 = "#005c7d"
" Grey70
let g:terminal_color_15 = "#b2b2b2"

if has('terminal')
    let g:terminal_ansi_colors = [
                \ g:terminal_color_0,
                \ g:terminal_color_1,
                \ g:terminal_color_2,
                \ g:terminal_color_3,
                \ g:terminal_color_4,
                \ g:terminal_color_5,
                \ g:terminal_color_6,
                \ g:terminal_color_7,
                \ g:terminal_color_8,
                \ g:terminal_color_9,
                \ g:terminal_color_10,
                \ g:terminal_color_11,
                \ g:terminal_color_12,
                \ g:terminal_color_13,
                \ g:terminal_color_14,
                \ g:terminal_color_15
                \ ]
endif

" Text                                                                                                            
highlight  Normal      term=NONE  ctermfg=7  ctermbg=0  cterm=NONE         guifg=#f1f1f1  guibg=#121212  guisp=NONE  gui=NONE
highlight  Bold        term=NONE  ctermfg=NONE  ctermbg=NONE  cterm=bold         guifg=NONE  guibg=NONE  guisp=NONE  gui=bold
highlight  Italic      term=NONE  ctermfg=NONE  ctermbg=NONE  cterm=italic       guifg=NONE  guibg=NONE  guisp=NONE  gui=italic
highlight  Underlined  term=NONE  ctermfg=NONE  ctermbg=NONE  cterm=underline    guifg=NONE  guibg=NONE  guisp=NONE  gui=underline
highlight  Conceal     term=NONE  ctermfg=NONE  ctermbg=NONE  cterm=bold,italic  guifg=NONE  guibg=NONE  guisp=NONE  gui=bold,italic

" Interface {{{
" TODO: I could not find a good match of colors for CursorColumn and
" CursorLine in cterm mode. HEnce I have used underline. Feel free to
" recommend better colors to fit this. But I think the 16 color pallete lacks
" a 5th grey pattern not used in any foreground or background, otherwise some
" texts become invisible. Reverse isn't also an option since it is used for
" search, visual and other markings.
" }}}
"
" CursorColumn and CursorLine are the only two that uses color outside the 16
" pallete. The color 8 makes the comments unreadable when on current line. =/
" Need to find a better solution.
highlight   CursorColumn      term=NONE       ctermfg=NONE  ctermbg=8     cterm=NONE       guifg=NONE     guibg=#303030  guisp=NONE  gui=NONE
highlight   CursorLine        term=underline  ctermfg=NONE  ctermbg=8     cterm=NONE       guifg=NONE     guibg=#303030  guisp=NONE  gui=NONE

highlight   ColorColumn       term=NONE       ctermfg=3     ctermbg=NONE  cterm=NONE       guifg=#ffb94c  guibg=NONE     guisp=NONE  gui=NONE

highlight   Cursor            term=NONE       ctermfg=NONE  ctermbg=4     cterm=NONE       guifg=NONE     guibg=#84a7f2  guisp=NONE  gui=NONE
highlight   lCursor           term=NONE       ctermfg=NONE  ctermbg=4     cterm=NONE       guifg=NONE     guibg=#84a7f2  guisp=NONE  gui=NONE
highlight!  link              TermCursor      Cursor                                                                                 
highlight!  link              TermCursorNC    lCursor                                                                                
highlight   NonText           term=NONE       ctermfg=NONE  ctermbg=NONE  cterm=NONE       guifg=NONE     guibg=NONE     guisp=NONE  gui=NONE
highlight   EndOfBuffer       term=NONE       ctermfg=NONE  ctermbg=NONE  cterm=NONE       guifg=NONE     guibg=NONE     guisp=NONE  gui=NONE
highlight   LineNr            term=NONE       ctermfg=8     ctermbg=0     cterm=NONE       guifg=#4e4e4e  guibg=#121212  guisp=NONE  gui=NONE
highlight   LineNrAbove       term=NONE       ctermfg=8     ctermbg=0     cterm=NONE       guifg=#4e4e4e  guibg=#121212  guisp=NONE  gui=NONE
highlight!  link              LineNrBelow     LineNrAbove                                                                            
highlight   CursorLineNr      term=NONE       ctermfg=3     ctermbg=0     cterm=bold       guifg=#ffb94c  guibg=#121212  guisp=NONE  gui=bold
highlight   SignColumn        term=NONE       ctermfg=8     ctermbg=0     cterm=NONE       guifg=#4e4e4e  guibg=#121212  guisp=NONE  gui=NONE
highlight   FoldColumn        term=NONE       ctermfg=8     ctermbg=0     cterm=NONE       guifg=#4e4e4e  guibg=#121212  guisp=NONE  gui=NONE
highlight   StatusLine        term=NONE       ctermfg=0     ctermbg=4     cterm=NONE       guifg=#121212  guibg=#84a7f2  guisp=NONE  gui=NONE
highlight   StatusLineNC      term=NONE       ctermfg=8     ctermbg=15    cterm=NONE       guifg=#4e4e4e  guibg=#b3b3b3  guisp=NONE  gui=NONE
highlight   StatusLineTerm    term=NONE       ctermfg=0     ctermbg=4     cterm=NONE       guifg=#121212  guibg=#84a7f2  guisp=NONE  gui=NONE
highlight   StatusLineTermNC  term=NONE       ctermfg=8     ctermbg=15    cterm=NONE       guifg=#4e4e4e  guibg=#b3b3b3  guisp=NONE  gui=NONE
highlight   WildMenu          term=NONE       ctermfg=7     ctermbg=14    cterm=NONE       guifg=#f1f1f1  guibg=#005c7d  guisp=NONE  gui=NONE
highlight   TabLineFill       term=NONE       ctermfg=0     ctermbg=0     cterm=NONE       guifg=#121212  guibg=#121212  guisp=NONE  gui=NONE
highlight   TabLine           term=bold       ctermfg=7     ctermbg=8     cterm=bold       guifg=#f1f1f1  guibg=#4e4e4e  guisp=NONE  gui=bold
highlight   TabLineSel        term=bold       ctermfg=7     ctermbg=4     cterm=bold       guifg=#f1f1f1  guibg=#84a7f2  guisp=NONE  gui=bold
highlight   VertSplit         term=NONE       ctermfg=0     ctermbg=7     cterm=NONE       guifg=#121212  guibg=#f1f1f1  guisp=NONE  gui=NONE
highlight   Title             term=NONE       ctermfg=8     ctermbg=4     cterm=NONE       guifg=#4e4e4e  guibg=#84a7f2  guisp=NONE  gui=NONE
highlight   Pmenu             term=NONE       ctermfg=NONE  ctermbg=8     cterm=NONE       guifg=NONE     guibg=#4e4e4e  guisp=NONE  gui=NONE
highlight   PmenuSel          term=NONE       ctermfg=4     ctermbg=8     cterm=NONE       guifg=#84a7f2  guibg=#4e4e4e  guisp=NONE  gui=NONE
highlight   PmenuThumb        term=NONE       ctermfg=7     ctermbg=15    cterm=NONE       guifg=#f1f1f1  guibg=#b3b3b3  guisp=NONE  gui=NONE
highlight   PmenuSbar         term=NONE       ctermfg=4     ctermbg=15    cterm=NONE       guifg=#84a7f2  guibg=#b3b3b3  guisp=NONE  gui=NONE

" Navigation                                                                                               
highlight   IncSearch  term=NONE     ctermfg=NONE  ctermbg=NONE  cterm=reverse,bold  guifg=NONE  guibg=NONE  guisp=NONE  gui=reverse,bold
highlight   Search     term=NONE     ctermfg=NONE  ctermbg=NONE  cterm=reverse,bold  guifg=NONE  guibg=NONE  guisp=NONE  gui=reverse,bold
highlight   Visual     term=reverse  ctermfg=NONE  ctermbg=NONE  cterm=reverse       guifg=NONE  guibg=NONE  guisp=NONE  gui=reverse
highlight!  link       VisualNOS     Visual                                                                              

" Syntax                                                                                      
highlight  Comment  term=NONE  ctermfg=8  ctermbg=0  cterm=italic  guifg=#4e4e4e  guibg=#121212  guisp=NONE  gui=italic

" Groups String Character Number Boolean Float
highlight    Constant          term=italic     ctermfg=7     ctermbg=NONE     cterm=italic       guifg=#f1f1f1     guibg=NONE     guisp=NONE  gui=italic

" Groups Function
highlight    Identifier        term=NONE       ctermfg=4     ctermbg=NONE     cterm=NONE         guifg=#84a7f2     guibg=NONE     guisp=NONE  gui=NONE

" Groups Conditional Repeat Label Operator Keyword Exception
highlight    Statement         term=bold       ctermfg=7     ctermbg=NONE     cterm=bold         guifg=#f1f1f1     guibg=NONE     guisp=NONE  gui=bold

" Groups Include Define Macro PreCondit
highlight    PreProc           term=NONE       ctermfg=7     ctermbg=NONE     cterm=NONE         guifg=#f1f1f1     guibg=NONE     guisp=NONE  gui=bold

" Groups StorageClass Structure Typedef
highlight    Type              term=NONE       ctermfg=15    ctermbg=NONE     cterm=NONE         guifg=#b3b3b3     guibg=NONE     guisp=NONE  gui=NONE

" Groups SpecialChar Tag Delimiter SpecialComment Debug
highlight   Special     term=NONE   ctermfg=2  ctermbg=NONE  cterm=NONE  guifg=#48d56b  guibg=NONE     guisp=NONE  gui=NONE
highlight!  link        Whitespace  NonText                                                                        
highlight   MatchParen  term=NONE   ctermfg=0  ctermbg=3     cterm=NONE  guifg=#121212  guibg=#ffb94c  guisp=NONE  gui=NONE

" Messages
highlight   Todo        term=bold  ctermfg=7   ctermbg=3  cterm=bold  guifg=#f1f1f1  guibg=#ffb94c  guisp=NONE  gui=bold
highlight   Error       term=bold  ctermfg=7   ctermbg=1  cterm=bold  guifg=#f1f1f1  guibg=#ff7c59  guisp=NONE  gui=bold
highlight!  link        ErrorMsg   Error                                                                       
highlight   WarningMsg  term=NONE  ctermfg=0   ctermbg=3  cterm=NONE  guifg=#121212  guibg=#ffb94c  guisp=NONE  gui=NONE
highlight   MoreMsg     term=NONE  ctermfg=15  ctermbg=8  cterm=NONE  guifg=#b3b3b3  guibg=#4e4e4e  guisp=NONE  gui=NONE
highlight   ModeMsg     term=NONE  ctermfg=15  ctermbg=8  cterm=NONE  guifg=#b3b3b3  guibg=#4e4e4e  guisp=NONE  gui=NONE
highlight!  link        Question   MoreMsg                                                                      
highlight   Folded      term=bold  ctermfg=15  ctermbg=8  cterm=bold  guifg=#b3b3b3  guibg=#4e4e4e  guisp=NONE  gui=bold

" Filetypes
highlight  Directory  term=bold  ctermfg=7  ctermbg=0  cterm=bold  guifg=#f1f1f1  guibg=#121212  guisp=NONE  gui=italic

" DIFF
highlight  DiffAdd     term=NONE  ctermfg=NONE  ctermbg=10  cterm=NONE  guifg=NONE  guibg=#076b47  guisp=NONE  gui=NONE
highlight  DiffDelete  term=NONE  ctermfg=NONE  ctermbg=9   cterm=NONE  guifg=NONE  guibg=#b51530  guisp=NONE  gui=NONE
highlight  DiffChange  term=NONE  ctermfg=NONE  ctermbg=14  cterm=NONE  guifg=NONE  guibg=#005c7d  guisp=NONE  gui=NONE
highlight  DiffText    term=NONE  ctermfg=NONE  ctermbg=13  cterm=NONE  guifg=NONE  guibg=#9700b7  guisp=NONE  gui=NONE

" Spelling
highlight  SpellBad      term=NONE  ctermfg=NONE  ctermbg=9   cterm=NONE  guifg=NONE     guibg=#b51530  guisp=NONE  gui=NONE
highlight  SpellRare     term=NONE  ctermfg=NONE  ctermbg=13  cterm=NONE  guifg=NONE     guibg=#9700b7  guisp=NONE  gui=NONE
highlight  SpellLocal    term=NONE  ctermfg=NONE  ctermbg=13  cterm=NONE  guifg=NONE     guibg=#9700b7  guisp=NONE  gui=NONE
highlight  SpellCap      term=NONE  ctermfg=NONE  ctermbg=13  cterm=NONE  guifg=NONE     guibg=#9700b7  guisp=NONE  gui=NONE
highlight  SpecialKey    term=NONE  ctermfg=8     ctermbg=0   cterm=NONE  guifg=#4e4e4e  guibg=#121212  guisp=NONE  gui=NONE
highlight  QuickFixLine  term=NONE  ctermfg=NONE  ctermbg=1   cterm=NONE  guifg=NONE     guibg=#ff7c59  guisp=NONE  gui=NONE
highlight  Terminal      term=NONE  ctermfg=7     ctermbg=0   cterm=NONE  guifg=#f1f1f1  guibg=#121212  guisp=NONE  gui=NONE
"
" PLUGINS
"

" Illuminated
highlight  illuminatedWord     term=NONE  ctermfg=NONE  ctermbg=NONE  cterm=reverse,bold  guifg=NONE     guibg=NONE  guisp=NONE  gui=reverse,bold
highlight  illuminatedCurWord  term=NONE  ctermfg=3     ctermbg=NONE  cterm=reverse,bold  guifg=#ffb94c  guibg=NONE  guisp=NONE  gui=reverse,bold

" COC
" highlight CocErrorHighlight guifg=#A8334C guibg=NONE guisp=NONE gui=underline
" highlight CocHintHighlight guifg=#88507D guibg=NONE guisp=NONE gui=underline
" highlight CocInfoHighlight guifg=#286486 guibg=NONE guisp=NONE gui=underline
" highlight CocMarkdownLink guifg=#3B8992 guibg=NONE guisp=NONE gui=underline
" highlight CocWarningHighlight guifg=#944927 guibg=NONE guisp=NONE gui=underline
" highlight! link CocCodeLens LineNr
" highlight! link CocErrorSign LspDiagnosticsDefaultError
" highlight! link CocErrorVirtualText LspDiagnosticsVirtualTextError
" highlight! link CocHintSign LspDiagnosticsDefaultHint
" highlight! link CocInfoSign LspDiagnosticsDefaultInformation
" highlight! link CocSelectedText SpellBad
" highlight! link CocWarningSign LspDiagnosticsDefaultWarning
" highlight! link CocWarningVitualText LspDiagnosticsVirtualTextWarning
"
"LSP
" highlight LspDiagnosticsDefaultHint guifg=#88507D guibg=NONE guisp=NONE gui=NONE
" highlight LspDiagnosticsDefaultInformation guifg=#286486 guibg=NONE guisp=NONE gui=NONE
" highlight LspDiagnosticsUnderlineError guifg=#A8334C guibg=NONE guisp=NONE gui=undercurl
" highlight LspDiagnosticsUnderlineHint guifg=#88507D guibg=NONE guisp=NONE gui=undercurl
" highlight LspDiagnosticsUnderlineInformation guifg=#286486 guibg=NONE guisp=NONE gui=undercurl
" highlight LspDiagnosticsUnderlineWarning guifg=#944927 guibg=NONE guisp=NONE gui=undercurl
" highlight LspDiagnosticsVirtualTextError guifg=#A8334C guibg=#E7DDDE guisp=NONE gui=NONE
" highlight LspDiagnosticsVirtualTextWarning guifg=#944927 guibg=#F0E6E4 guisp=NONE gui=NONE
" highlight! link LspCodeLens LineNr
" highlight! link LspDiagnosticsDefaultError Error
" highlight! link LspDiagnosticsDefaultWarning WarningMsg
" highlight! link LspReferenceRead ColorColumn
" highlight! link LspReferenceText ColorColumn
" highlight! link LspReferenceWrite ColorColumn

" GIT
" highlight GitSignsAdd guifg=#617437 guibg=NONE guisp=NONE gui=NONE
" highlight GitSignsChange guifg=#286486 guibg=NONE guisp=NONE gui=NONE
" highlight GitSignsDelete guifg=#A8334C guibg=NONE guisp=NONE gui=NONE

" Neo GIT
" highlight NeogitHunkHeaderHighlight guifg=#2C363C guibg=#E6E1DF guisp=NONE gui=bold
" highlight! link NeogitDiffAddHighlight DiffAdd
" highlight! link NeogitDiffContextHighlight CursorLine
" highlight! link NeogitDiffDeleteHighlight DiffDelete
" highlight! link NeogitHunkHeader LineNr
" highlight! link NeogitNotificationError LspDiagnosticsDefaultError
" highlight! link NeogitNotificationInfo LspDiagnosticsDefaultInformation
" highlight! link NeogitNotificationWarning LspDiagnosticsDefaultWarning

" Barbar
" highlight BufferVisible term=NONE ctermfg=8 ctermbg=6 cterm=NONE guifg=#4e4e4e guibg=#39e7d8 guisp=NONE gui=NONE
" highlight BufferVisibleIndex guifg=#596A76 guibg=NONE guisp=NONE gui=NONE
" highlight BufferVisibleSign guifg=#596A76 guibg=NONE guisp=NONE gui=NONE
" highlight! link BufferCurrent TabLineSel

" Misc
" highlight SneakLabelMask guifg=#88507D guibg=#88507D guisp=NONE gui=NONE
" highlight! link SneakLabel WildMenu
" highlight! link Sneak Search
"
" highlight TelescopeMatching guifg=#88507D guibg=NONE guisp=NONE gui=bold
" highlight TelescopeSelectionCaret guifg=#A8334C guibg=#E6E1DF guisp=NONE gui=NONE

" highlight TSTag guifg=#4D5C65 guibg=NONE guisp=NONE gui=bold
" highlight! link TSVariable Identifier
" highlight! link TelescopeBorder FloatBorder
" highlight! link TelescopeSelection CursorLine

" highlight NormalFloat guifg=NONE guibg=#E1DCD9 guisp=NONE gui=NONE
" highlight FloatBorder guifg=#786D68 guibg=NONE guisp=NONE gui=NONE
" highlight IndentBlanklineChar term=NONE ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE guisp=NONE gui=NONE

