let g:tex_flavor = "latex" 
let g:Tex_Leader = '`'
let g:Tex_Leader2 = ','
let g:Tex_DefaultTargetFormat = 'pdf'

" <leader>ll compile
"         lv view

" Commom vim latex mapping

" Section mapping
" Tex_Leader2 + ...
" SPA Part 
" SCH Chapter
" SSE SEction
" SSS Subsection
" SS2 Subsubseciton
" SPG Paragraph
" SSP subparagraph

" Environment mapping
" Tex_Leader2 + ...
" EDE Description
" ELI list
" EIT Itemize
" ECE centered
" EAR Array
" EEQ Equation
" EAL Align
" EMA Math
" EQN
"
" Font mapping
" Tex_Leader + ...
" FEM  emphasys


" 
" "KEYS: <f5> S<F1...4> S<F5>  <f7>
"
"
" "Greep letters ` +
" "D F H Q L X Y S U W
" " MACROS INSERT MODE
" " Jump = CTRL+J need to change to CTRL+ENTER
" " EFI, 
" " SSE, SSS
"
"


" For finite differences u_i^j
call IMAP (g:Tex_Leader.'u', "u_{<++>}^{<++>}<++>", 'tex')

" Common Sets
call IMAP ('CC', '\mathbb{C} ', 'tex')
call IMAP ('NN', '\mathbb{N} ', 'tex')
call IMAP ('QQ', '\mathbb{Q} ', 'tex')
call IMAP ('RR', '\mathbb{R} ', 'tex')
call IMAP ('ZZ', '\mathbb{Z} ', 'tex')

" Norm/Cardinality  |u| or ||u||
call IMAP (g:Tex_Leader.'|', '\Big|  \Big|<++>', 'tex')
call IMAP ('||', '\left| <++> \right| <++>', 'tex')

" Dot product notation < u, v >
call IMAP (g:Tex_Leader.'P', '\langle <++>, <++> \rangle <++>', 'tex')

" <a> what for?
call IMAP ('<<',             '\langle <++> \rangle <++> ', 'tex')

