
syntax on
filetype plugin indent on

set nocompatible
" File encoding
set encoding=utf-8
set fileencodings=utf-8,ucs-bom,chinese,taiwan,latin1
let &termencoding=&encoding

" File formats
set fileformats=unix,dos,mac

" Indenting
set expandtab
set smarttab
set tabstop=4
set shiftwidth=4
set autoindent
set smartindent

" Editing
set backspace=indent,eol,start
set whichwrap+=<,>,h,l
set autoread

" Displaying
set number
set nowrap
set linespace=0
set textwidth=0
set nolinebreak
set hidden
set scrolloff=7
set scrolljump=3
set showmatch
set matchtime=2
set matchpairs=(:),[:],{:},<:>
set lazyredraw

" Disable bells
set noerrorbells
set novisualbell
set t_vb=
set tm=500
set report=0

" Command line
set showcmd
set history=100
set wildmenu
set wildmode=list,longest,full
set wildignore=*~,*.o,*.so,*.so.*,*.a,*.d,*.pyc,*.pyo,*.class
set shortmess+=filmnrxoOtT

" Making View
"set viewoptions=folds,options,cursor,unix,slash
"au BufWinLeave * silent! mkview
"au BufWinEnter * silent! loadview

" Save editing position
if has("autocmd")
    autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \ exec "normal g'\"" |
        \ endif
endif

" Status line
set ruler
set statusline=[%F]%y%r%m%*%=[Line:%l/%L,Column:%c][%p%%]
set laststatus=2

" Searching/Replacing
set magic
set ignorecase
set smartcase
set hlsearch
set incsearch
set gdefault
set wrapscan

" Folding
set foldenable
set foldmethod=syntax
set foldlevel=100

" Backing up
set backup
set writebackup
set backupdir=~/.tmp,/tmp
if !isdirectory($HOME.'/.tmp')
    if exists('*mkdir')
        call mkdir($HOME.'/.tmp', '', 0755)
    else
        call system('mkdir '.$HOME.'/.tmp')
    endif
endif

" Swapping
set noswapfile

" Disable mouse
set mouse=

" Highlighting the current line
if exists('+cursorline')
    set cursorline
endif


" Coloring
colorscheme desert
hi ColorColumn ctermbg=darkgray guibg=darkgray

" GUI settings
if has('gui_running')
    if has('win32') || has('win64')
        set guifont=Courier_New:h9:cANSI
    else
        set guifont=Luxi\ Mono\ 9
    endif
    set guioptions-=m
    set guioptions-=T
    set t_Co=256
endif

" Search paths
if has('unix')
    set path=.,/usr/local/include,/usr/include
    set path+=/usr/include/c++/**
    set path+=./include,../include
endif

" Mapping - mapleader
let mapleader=','
let g:mapleader=','

" Mapping - quit/save
nmap <leader>q :qa!<cr>
nmap <leader>wq :wqa!<cr>
nmap <leader>ww :w!<cr>
nmap <leader>wa :wa!<cr>
nmap <leader>w! :w !sudo tee % >/dev/null<cr><cr>

" Mapping - buffer switching
nmap <c-n> :bn<cr>
nmap <c-p> :bp<cr>

" Mapping - pasting mode toggle
nmap <leader>p :setlocal paste!<cr>

" Mapping - avoiding typo
nnoremap ; :

" Mapping - folding
nmap <leader>f0 :set foldlevel=0<cr>
nmap <leader>f1 :set foldlevel=1<cr>
nmap <leader>f2 :set foldlevel=2<cr>
nmap <leader>f3 :set foldlevel=3<cr>
nmap <leader>f4 :set foldlevel=4<cr>
nmap <leader>f5 :set foldlevel=5<cr>
nmap <leader>f6 :set foldlevel=6<cr>
nmap <leader>f7 :set foldlevel=7<cr>
nmap <leader>f8 :set foldlevel=8<cr>
nmap <leader>f9 :set foldlevel=9<cr>

" Mapping - clear highlighted search
nmap <silent> <leader>/ :nohls<cr>

" Mapping - visual shifting (does not exit visual mode)
vnoremap < <gv
vnoremap > >gv
vnoremap = =gv

" Remove trailing whitespace and ^M chars
"autocmd FileType c,cpp,java,php,js,python,twig,xml,yml
"    \ autocmd BufWritePre <buffer>
"    \ :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))

"""
""" Plugins
"""
if has("win32") || has ('win64')
    let g:vimPath = $HOME."/vimfiles/"
else
    let g:vimPath = $HOME."/.vim/"
endif
