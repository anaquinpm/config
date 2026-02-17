"===========================================================
"                PURE VIM - DEVOPS EDITION
"===========================================================

"-----------------------------------------------------------
" Básico
"-----------------------------------------------------------
set nocompatible              " Desactiva modo compatible con vi clásico
syntax enable                 " Activa resaltado de sintaxis
filetype plugin indent on     " Detecta tipo de archivo y aplica indentación
let mapleader = " "

"-----------------------------------------------------------
" Interfaz y experiencia visual
"-----------------------------------------------------------
set number                    " Muestra número absoluto de línea
set relativenumber            " Muestra números relativos (mejor navegación)
set cursorline                " Resalta la línea actual
set signcolumn=yes            " Siempre muestra columna para git/diagnósticos
set scrolloff=8               " Mantiene 8 líneas visibles arriba/abajo
set splitbelow splitright     " Nuevos splits abajo y a la derecha
set background=dark           " Optimizado para terminal oscuro

"-----------------------------------------------------------
" Búsqueda inteligente
"-----------------------------------------------------------
set ignorecase                " Ignora mayúsculas por defecto
set smartcase                 " Si uso mayúsculas, busca case-sensitive
set incsearch                 " Búsqueda incremental
set hlsearch                  " Resalta coincidencias
nnoremap <leader><space> :nohlsearch<CR>  " Limpia resaltado

"-----------------------------------------------------------
" Navegación y búsqueda estilo IDE (sin LSP)
"-----------------------------------------------------------
set wildmenu                  " Autocompletado mejorado en comandos
set path+=**                  " Permite :find en subdirectorios
set wildignore+=*/.git/*,*/node_modules/*,*/__pycache__/*,*.pyc

" Usar ripgrep si está instalado (mucho más rápido que grep)
if executable('rg')
  set grepprg=rg\ --vimgrep
endif

" Buscar en proyecto y abrir quickfix
nnoremap <leader>g :grep<Space>
nnoremap <leader>q :copen<CR>
nnoremap <leader>c :cclose<CR>

"-----------------------------------------------------------
" Indentación global (DevOps-friendly)
" YAML / HCL suelen usar 2 espacios
"-----------------------------------------------------------
set tabstop=2
set shiftwidth=2
set expandtab                 " Convierte tabs en espacios
set autoindent
set smartindent

"-----------------------------------------------------------
" Configuración específica por lenguaje
"-----------------------------------------------------------

" Python usa 4 espacios
autocmd FileType python setlocal tabstop=4 shiftwidth=4 expandtab
autocmd FileType python setlocal colorcolumn=88   " Límite recomendado por Black

" YAML / Kubernetes
autocmd FileType yaml setlocal tabstop=2 shiftwidth=2 expandtab

" Bash
autocmd FileType sh setlocal tabstop=2 shiftwidth=2 expandtab

"-----------------------------------------------------------
" Herramientas externas (formateo / validación)
"-----------------------------------------------------------

" Python
nnoremap <leader>f :!black %<CR>          " Formatear con Black
nnoremap <leader>r :!ruff %<CR>           " Lint con Ruff

" Terraform
nnoremap <leader>tf :!terraform fmt %<CR>

" Kubernetes YAML
nnoremap <leader>k :!kubectl apply --dry-run=client -f %<CR>

" Bash
nnoremap <leader>s :!shellcheck %<CR>

"-----------------------------------------------------------
" ctags para navegación tipo "Go to Definition"
" Requiere: brew install universal-ctags
" Generar en proyecto: ctags -R .
"-----------------------------------------------------------
set tags=./tags;,tags;

" Ctrl-]  -> Ir a definición
" Ctrl-t  -> Volver

"-----------------------------------------------------------
" Performance
"-----------------------------------------------------------
set updatetime=300
set hidden                     " Permite cambiar buffer sin guardar

"-----------------------------------------------------------
" Omni completion settings
"-----------------------------------------------------------
"| Acción                           | Tecla           |
"| -------------------------------- | --------------- |
"| Autocomplete básico              | `Ctrl-n`        |
"| Autocomplete omnifunc            | `Ctrl-x Ctrl-o` |
"| Autocomplete archivos            | `Ctrl-x Ctrl-f` |
"| Autocomplete palabras del buffer | `Ctrl-n`        |

set completeopt=menuone,noinsert,noselect

autocmd FileType python     setlocal omnifunc=python3complete#Complete
autocmd FileType sh         setlocal omnifunc=syntaxcomplete#Complete
autocmd FileType terraform  setlocal omnifunc=syntaxcomplete#Complete
autocmd FileType yaml       setlocal omnifunc=syntaxcomplete#Complete
autocmd FileType json       setlocal omnifunc=syntaxcomplete#Complete
autocmd FileType dockerfile setlocal omnifunc=syntaxcomplete#Complete


"-----------------------------------------------------------
" Markdown fenced languages (syntax highlight en bloques)
"-----------------------------------------------------------
let g:markdown_fenced_languages = [
      \ 'html',
      \ 'python',
      \ 'bash=sh',
      \ 'javascript',
      \ 'js=javascript',
      \ 'json=javascript',
      \ 'yaml',
      \ 'yml=yaml'
      \ ]

"-----------------------------------------------------------
" Plugins mínimos (Pure Vim Philosophy)
"-----------------------------------------------------------
" Instalar vim-plug primero si no está instalado

call plug#begin('~/.vim/plugged')

" Edición estructural poderosa
" Plug 'tpope/vim-surround'      " Cambiar cosas como ( " ' tags fácilmente
" Plug 'tpope/vim-repeat'        " Repetir plugins con .
" Plug 'tpope/vim-commentary'    " Comentar código fácilmente

" Git liviano pero potente
" Plug 'tpope/vim-fugitive'      " Git dentro de Vim
" Plug 'airblade/vim-gitgutter'  " Muestra cambios respecto a HEAD

" Mejor soporte YAML / trf / HCL
Plug 'stephpy/vim-yaml'
Plug 'hashivim/vim-terraform'

call plug#end()

"===========================================================
"                 FIN CONFIGURACIÓN
"===========================================================

