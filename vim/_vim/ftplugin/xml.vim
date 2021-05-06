setlocal tabstop=2
setlocal softtabstop=2
setlocal shiftwidth=2
setlocal nowrap

" Ident
setlocal autoindent
setlocal smartindent
setlocal expandtab

" XML Plugin
"let g:xml_syntax_folding=1
"setlocal foldmethod=syntax

setlocal foldmethod=indent
setlocal foldlevelstart=999
setlocal foldminlines=0


autocmd BufEnter,BufNew *.ui nnoremap <F5> :!gtk4-builder-tool preview % <CR>
autocmd BufEnter,BufNew *.ui inoremap <F5> <ESC>:!gtk4-builder-tool preview % <CR>
autocmd BufEnter,BufNew *.ui nnoremap <F6> :!gtk4-builder-tool validate % <CR>
autocmd BufEnter,BufNew *.ui inoremap <F6> <ESC>:!gtk4-builder-tool validate % <CR>

"xml editing hints
" > close tag
" >> close idented tag
" ;; last word as tag
" <Leader>5  matching tag
" <Leader>c  rename tag
" <Leader>d  remove tag
" <Leader>e  build close tag
" <Leader>o  Insert tag inside current
" <Leader>I  indent all
"
"nnoremap <leader>xl <leader>cd:%w !xmllint --valid --noout -
" nnoremap <leader>xr <leader>cd:%w !rxp -V -N -s -x
" nnoremap <leader>xs :%!xsltlint
" nnoremap <leader>xd :%w !xmllint --dtdvalid
"  \ "http://www.oasis-open.org/docbook/xml/4.2/docbookx.dtd"
"  \ --noout -
" vnoremap <leader>px !xmllint --format -
" nnoremap <leader>px !!xmllint --format -
" nnoremap <leader>pxa :%!xmllint --format -

function XmlAttribCallback (xml_tag)
    if a:xml_tag ==? "action-widget"
        return "response=\"++\" default=\"true\""
    elseif a:xml_tag ==? "signal"
        return "name=\"++\" handler=\"++\" swapped=\"++\" object=\"++\""
    else
        return 0
    endif
endfunction


"GTK Helpers
"
func Eatchar(pat)
   let c = nr2char(getchar(0))
   return (c =~ a:pat) ? '' : c
endfunc

" Elements
iabbrev xml <?xml version="1.0" encoding="UTF-8"?>=Eatchar('\s')<cr>
iabbrev childinternal <child internal-child="+++">><ESC>?+++<cr>
" Objects
iabbrev gtkdialog <object class="GtkDialog" id="+++">><ESC>?+++<cr>
iabbrev gtkbox <object class="GtkBox" id="+++">><ESC>?+++<cr>
iabbrev gtklabel <object class="GtkLabel" id="+++">><ESC>?+++<cr>
iabbrev gtkfontbutton <object class="GtkFontButton" id="+++">><ESC>?+++<cr>
iabbrev gtkimage <object class="GtkImage" id="+++">><ESC>?+++<cr>
iabbrev gtkbutton <object class="GtkButton" id="+++">><ESC>?+++<cr>
iabbrev template <template class="+++" parent="+++">><ESC>?+++<cr>

" Properties
iabbrev proporientation    <property name="orientation"><c-r>=Eatchar('\s')<cr>
iabbrev propspacing        <property name="spacing"><c-r>=Eatchar('\s')<cr>
iabbrev propmarginstart    <property name="margin-start"><c-r>=Eatchar('\s')<cr>
iabbrev propmarginend      <property name="margin-end"><c-r>=Eatchar('\s')<cr>
iabbrev propmargintop      <property name="margin-top"><c-r>=Eatchar('\s')<cr>
iabbrev propmarginbottom   <property name="margin-bottom"><c-r>=Eatchar('\s')<cr>
iabbrev proplabel          <property name="label"><c-r>=Eatchar('\s')<cr>
iabbrev propxalign         <property name="xalign"><c-r>=Eatchar('\s')<cr>
iabbrev proptitle          <property name="title"><c-r>=Eatchar('\s')<cr>
iabbrev propresizable      <property name="resizable"><c-r>=Eatchar('\s')<cr>
iabbrev propmodal          <property name="modal"><c-r>=Eatchar('\s')<cr>
iabbrev proptransientfor   <property name="transient-for"><c-r>=Eatchar('\s')<cr>
iabbrev propiconname       <property name="icon-name"><c-r>=Eatchar('\s')<cr>
iabbrev propiconsize       <property name="icon-size"><c-r>=Eatchar('\s')<cr>
iabbrev propactionname     <property name="action-name"><c-r>=Eatchar('\s')<cr>


"Attributes
iabbrev attrlabel <attribute name="label"><c-r>=Eatchar('\s')<cr>
iabbrev attraction <attribute name="action"><c-r>=Eatchar('\s')<cr>



