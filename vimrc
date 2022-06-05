" Local vim configuration file
" ln -s this_file ~/.vim/vimrc

set nocompatible
if has("syntax")
  syntax on
endif


filetype plugin indent on
set background=dark
set showcmd         " Show (partial) command in status line.
set smartcase       " Do smart case matching
set incsearch       " Incremental search
set autowrite       " Automatically save before commands like :next and :make

" Indentación y caracteres especiales
se nu rnu           " n° de la línea en que estamos y el n° de lineas relativos a ella
set colorcolumn=81  " Linea en los 80 caracteres
set tabstop=4       " muestra los tabs como 4 espacios
set shiftwidth=4    " indentacion con 4 espacios
set autoindent      " indent new lines to match the current indentation
"set noexpandtab    " don’t replace tabs with spaces
set expandtab       " replace tabs with spaces
set smarttab        " use tabs at the start of a line, spaces elsewhere
set hls             " resalta los resultados de busqueda

" Colorear lenguajes
let g:markdown_fenced_languages = ['html', 'python', 'bash=sh', 'javascript', 'js=javascript', 'json=javascript', 'sass']

" Muestra en las busquedas el numero de ocurrencias y en cual estamos parados
set shortmess-=S

" show whitespace at the end of a line
highlight WhitespaceEOL ctermbg=blue guibg=blue
match WhitespaceEOL /\s\+$/

"-------------------------------------------------------------------------------
" Nuevos splits a la derecha y abajo
set splitbelow splitright

" Remap de navegación en las ventanas
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Adjusting split sizes
noremap <silent> <C-Left> :vertical resize +3<CR>
noremap <silent> <C-Right> :vertical resize -3<CR>
noremap <silent> <C-Up> :resize +3<CR>
noremap <silent> <C-Down> :resize -3<CR>

" netrw: directory view
let g:netrw_preview=1         " Preview windows in vertical split windows
let g:netrw_alto=0            " En conjunto con la opción de arriba el split lo realiza: topleft
let g:netrw_liststyle=3       " Vista tree
let g:netrw_browse_split=4    " 2 Open in new vertical split. 1 horizontal split, 3 new tab, 4 open in previus windows
let g:netrw_winsize=80        " Tamaño del explorador en porcentaje%
let g:netrw_banner=0          " Elimina el banner del explorer


" Busca recursivamente en los subfolders (:find)
set path+=**
set wildmenu                  " Display all matching file when we tab

" General remaps
nnoremap <silent> <C-s> :w<CR>
"-------------------------------------------------------------------------------

" Abbreviations -> abbr <shortcut> <string>
abbr _sh #!/usr/bin/env bash
abbr _py #!/usr/bin/env python3

"-------------------------------------------------------------------------------
" Vim-plug - Automatic installation
"-------------------------------------------------------------------------------

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')

Plug 'vim-airline/vim-airline'      " Muestrala barra inferior con información
Plug 'vimwiki/vimwiki'              " Wikipedia personal en MD file
"Plug 'SirVer/ultisnips'            " Crear snippets personalizados

" File explorer
Plug 'scrooloose/nerdtree'
Plug 'ryanoasis/vim-devicons'

" Git
Plug 'tpope/vim-fugitive'           " Manejo de git
Plug 'airblade/vim-gitgutter'       " Muestra las modificiones respecto del último commit de git

" General Sintax
Plug 'tpope/vim-surround'           " Agrega/quitar/modificar signos/tags que rodean texto
Plug 'jiangmiao/auto-pairs'         " Insert or delete brackets, parens, quotes in pair.
Plug 'preservim/nerdcommenter'      " Crea comentarios
Plug 'prettier/vim-prettier'
Plug 'ap/vim-css-color'             " Color previews

" JS and ReactJs
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'

call plug#end()

"-------------------------------------------------------------------------------
" NerdTree mapping
"-------------------------------------------------------------------------------
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

" Start NERDTree when Vim is started without file arguments.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif
