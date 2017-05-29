" ======================================================================
" VIM
" ======================================================================

" Plugins {{{
" ======================================================================
set nocompatible
filetype off
call plug#begin('~/.vim/plugged')

" https://github.com/ludovicchabant/vim-gutentags
Plug 'ludovicchabant/vim-gutentags'

"Plug 'mbbill/undotree'

" http://vim-latex.sourceforge.net/
Plug 'vim-latex/vim-latex'

" https://github.com/romainl/vim-qf
Plug 'romainl/vim-qf'
" https://github.com/romainl/vim-qlist
Plug 'romainl/vim-qlist'

Plug 'tpope/vim-git'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-tbone'

Plug 'tpope/vim-markdown'
augroup readMarkdown
    autocmd BufNewFile,BufReadPost *.md set filetype=markdown
augroup END
let g:markdown_fenced_langagues = ['html', 'python','bash=sh','c']

Plug 'tpope/vim-vinegar'
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'

Plug 'tpope/vim-rhubarb'

Plug 'tpope/vim-obsession'
".
"FOR PYTHON
Plug 'tell-k/vim-autopep8'
Plug 'ivanov/vim-ipython'
Plug 'tmhedberg/SimpylFold'

Plug 'freitass/todo.txt-vim' 

" Themes
Plug 'romainl/flattened'
Plug 'vim-scripts/Sift'
Plug 'bounceme/highwayman'
Plug 'lanox/lanox-vim-theme'
Plug 'tpope/vim-vividchalk'

call plug#end()
" }}}

" Theme and graph {{{
" ======================================================================
if has("gui_running")
    set guioptions-=m
    set guioptions-=T
    set mouse=a
endif

" Some colors
set listchars=tab:>\ ,eol:¬

silent! colorscheme flattened_dark

" Status line
highlight StatusLine NONE ctermbg=DarkBlue ctermfg=White cterm=NONE

if has("statusline")
  set statusline =              " clear
  set statusline+=\ %02n        " leading zero 2 digit buffer number
  set statusline+=\ %#IncSearch#    " Color
  set statusline+=\ %<%F        " file full path, truncate
  set statusline+=\ %*
  set statusline+=\ %r          " read only flag '[RO]'
  set statusline+=\ %m          " modified flag '[+]' if modifiable
  set statusline+=\ %h          " help flag '[Help]'
  set statusline+=\ %{fugitive#statusline()}    " GIT Branch
  set statusline+=\ %{gutentags#statusline()}
  set statusline+=%=            " left/right separation point
  set statusline+=\ \|\ %{&ff}  " fileformat
  set statusline+=\ \|\ %{strlen(&ft)?&ft:'none'}      " filetype
  set statusline+=\ \|\ [%03b   " decimal byte
  set statusline+=\ x%02B]      " hex byte ' \x62'
  set statusline+=\ (%04v,%04l) " (x,y)
  set statusline+=\ \|\ %P    " percent of file
  set statusline+=\ of
  set statusline+=\ %L          " line/lines
  set statusline+=\ lines
endif

" }}}

" Basic Settings {{{
" ==========================================================
let mapleader=" "
let maplocalleader=" "

" Composing
set undolevels=1000
set linebreak
set wrap
set virtualedit=block
set numberwidth=5
set relativenumber
set nonumber
set cursorline

" Navigating
set viminfo^=%
set scrolloff=5

" Indent
set shiftround

" Search
set showmatch
set matchpairs+=<:>
set smartcase
set hlsearch

" Menu
set wildmode=longest:list,full
set wildignore+=tags,cscope.out,*.o,*~,*.pyc,.tags
set wildignorecase

" File handling
set backup
set backupdir=~/.tmp,~/tmp
set swapfile
set directory=~/.tmp,~/tmp
set undofile
set undodir=~/.tmp,~/tmp
set writebackup
set path=.,**

" Terminal settings
set title
set titleold=""

" Split windows
set splitbelow
set splitright

" Buffers
set hidden

" Tags startup
set tags=.tags;tags;${HOME}

" Unecessary and slow
"match WarningMsg '\%>80v.\+'

"}}}

" Maps/Macros {{{
" ================================================

nnoremap <ESC><ESC><ESC> :q<CR>
" ctrl-jklm  changes to that split
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l
nnoremap <c-h> <c-w>h
" nnoremap <c-J> <c-w>J
" nnoremap <c-K> <c-w>K
" nnoremap <c-L> <c-w>L
" nnoremap <c-H> <c-w>H
nnoremap <leader>w <C-w>v<C-w>l

" Famous shortcuts
nnoremap <leader>a :argadd <c-r>=fnameescape(expand('%p:h'))<cr>/*<C-d>
nnoremap <leader>f :find *
nnoremap <leader>l :set list!<cr>
nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<cr>
nnoremap <leader>m :make<CR>
nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<cr>
nnoremap <leader>m :make<CR>
nnoremap <leader>/ :nohlsearch<cr>
nnoremap <leader><space> za

" Space strip all
nnoremap _$ :call Preserve("%s/\\s\\+$//e")<CR>
" Identall
nnoremap _= :call Preserve("normal gg=G")<CR>

" W use capital w to write too..
command! W :w

" sudo write this
cmap W! w !sudo tee % >/dev/null
cmap w!! w !sudo tee % >/dev/null

"}}}

" Function keys {{{
" ======================================================================

set pastetoggle=<F1>

" Buffers
inoremap <F2> <ESC>:bp!<CR>
nnoremap <F2>      :bp!<CR>

inoremap <F3> <ESC>:bn!<CR>
nnoremap <F3>      :bn!<CR>

inoremap <F4> <ESC>:buffers<CR>:buffer<Space>
nnoremap <F4>      :buffers<CR>:buffer<Space>

"inoremap <F5> <ESC>
"nnoremap <F5>

inoremap <F6> <ESC>:vimgrep // **/*<left><left><left><left><left><left>
nnoremap <F6>      :vimgrep // **/*<left><left><left><left><left><left>

"inoremap <F7> <ESC>
"nnoremap <F7>

"inoremap <F8> <ESC>
"nnoremap <F8>

"inoremap <F9> <ESC>
"nnoremap <F9>

"inoremap <F10> <ESC>
"nnoremap <F10>

" Quickfix navigation
" Maybe start to use only unimpaired shortcuts
inoremap   <F11> <ESC>:cprev<CR>
nnoremap   <F11>      :cprev<CR>

inoremap   <F12> <ESC>:cnext<CR>
nnoremap   <F12>      :cnext<CR>

inoremap <C-F11> <ESC>:cpfile<CR>
nnoremap <C-F11>      :cpfile<CR>

inoremap <C-F12> <ESC>:cnfile<CR>
nnoremap <C-F12>      :cnfile<CR>

inoremap <S-F11> <ESC>:colder<CR>
nnoremap <S-F11>      :colder<CR>

inoremap <S-F12> <ESC>:cnewer<CR>
nnoremap <S-F12>      :cnewer<CR>
"}}}

" Functions {{{
" ======================================================================

function! HardVim()
    nnoremap <up> <nop>
    nnoremap <down> <nop>
    nnoremap <left> <nop>
    nnoremap <right> <nop>
    inoremap <up> <nop>
    inoremap <down> <nop>
    inoremap <left> <nop>
    inoremap <right> <nop>
endfunction
call HardVim()

function! Preserve(command)
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " Do the business:
  execute a:command
  " Clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction
"}}}

" Groups {{{
" ======================================================================

if has("autocmd")
    augroup autosave
        autocmd!
        autocmd FocusLost * :wa
"        autocmd BufWritePre *.py,*.js,*.c :call Preserve("%s/\\s\\+$//e")<CR>
    augroup END

    augroup reload_vimrc
        autocmd!
        autocmd bufwritepost $MYVIMRC source $MYVIMRC
    augroup END

    augroup openingbuffer
        autocmd!
        " Return to last edit position when opening files (You want this!)
        autocmd BufReadPost *
                    \ if line("'\"") > 0 && line("'\"") <= line("$") |
                    \   exe "normal! g`\"" |
                    \ endif |
    augroup END

    augroup numbering
        autocmd!
        autocmd InsertEnter * :set number | :set norelativenumber
        autocmd InsertLeave * :set relativenumber | :set nonumber
    augroup END

    augroup filetypes
        autocmd!
        autocmd BufNewFile,BufRead *.xhtml  setlocal ft=html
        autocmd BufNewFile,BufRead *.mako,*.mak,*.jinja2   setlocal ft=html
    augroup END

endif

"}}}

" Plugins {{{
" ======================================================================

let g:tex_flavor = "latex" 

if executable("ag")
    set grepprg=ag\ --nogroup\ --nocolor\ --ignore-case\ --column
    set grepformat=%f:%l:%c:%m,%f:%l:%m
endif

let g:gutentags_ctags_exclude = ['*.css', '*.html', '*.js']
let g:gutentags_cache_dir='~/.vim/gutentags'
let g:gutentags_project_root=[ 'Makefile', 'setup.py' ]
"}}}

" vim:foldmethod=marker:foldlevel=0
