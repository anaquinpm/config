runtime! debian.vim

if has("syntax")
  syntax on
endif

set background=dark

filetype plugin indent on

set showmatch		" Show matching brackets.
set smartcase		" Do smart case matching
set incsearch		" Incremental search
set autowrite		" Automatically save before commands like :next and :make

if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif

se nu			"muestra los numeros en las lineas
set hls			"resalta los resultados de busqueda
set tabstop=4		"muestra los tabs como 4 espacios
set shiftwidth=2	"indentacion con 4 espacios

" show whitespace at the end of a line
highlight WhitespaceEOL ctermbg=blue guibg=blue
match WhitespaceEOL /\s\+$/

" indent new lines to match the current indentation
set autoindent
" don’t replace tabs with spaces
set noexpandtab
" use tabs at the start of a line, spaces elsewhere
set smarttab
