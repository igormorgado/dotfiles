source $VIMRUNTIME/syntax/xml.vim<CR>
set foldmethod=syntax<CR>
source $VIMRUNTIME/syntax/syntax.vim<CR>
source $HOME/.vim/bundle/xmledit/ftplugin/xml.vim<CR>
inoremap \> ><CR>
iunmap <buffer> <leader>><CR>
echo "XML mode is on"

iunmap <buffer> <leader>.<CR> 

nmap <leader>xl <leader>cd:%w !xmllint --valid --noout -<CR>
nmap <leader>xr <leader>cd:%w !rxp -V -N -s -x<CR>
nmap <leader>xs :%!xsltlint<CR>
nmap <leader>xd :%w !xmllint --dtdvalid
 \ "http://www.oasis-open.org/docbook/xml/4.2/docbookx.dtd"
 \ --noout -<CR>

vmap <leader>px !xmllint --format -<CR>
nmap <leader>px !!xmllint --format -<CR>
nmap <leader>pxa :%!xmllint --format -<CR>

