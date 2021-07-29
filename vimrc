" Basics:
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set viminfo='20,\"1024
set history=200
set ruler
" set cursorline
set showmode showcmd
" StatusLine always visible, display full path
" http://learnvimscriptthehardway.stevelosh.com/chapters/17.html
set laststatus=2 statusline=%F

set hlsearch incsearch ignorecase smartcase
set showmatch

set autochdir

" http://stackoverflow.com/questions/9511253/how-to-effectively-use-vim-wildmenu
set wildmenu wildmode=list:longest,full
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,.DS_Store,.*.un~

set visualbell
if has('mouse')
	set mouse=a
endif
" use system clipboard on OSX
set clipboard=unnamed

" don't limit window dimensions
set winminwidth=0 winminheight=0
set ttyfast lazyredraw

set scrolloff=10
set colorcolumn=81

set fileencodings=utf8 enc=utf8
set expandtab tabstop=4 softtabstop=4 shiftwidth=4
set autoindent

set autoread
" http://stackoverflow.com/questions/2490227/how-does-vims-autoread-work#20418591
au FocusGained,BufEnter * :silent! !
set hidden

" File safety:
if !isdirectory($HOME . "/.vim-tmp")
    call mkdir($HOME . "/.vim-tmp/backup", "p", 0700)
    call mkdir($HOME . "/.vim-tmp/swap", "p", 0700)
    call mkdir($HOME . "/.vim-tmp/undo", "p", 0700)
endif
set backup
set backupdir=~/.vim-tmp/backup/
if has("persistent_undo")
	set undofile
	set undodir=~/.vim-tmp/undo/
endif
" If we backup temporary files often automated editing tools like the crontab
" editor get confused
set backupskip=/tmp/*,/private/tmp/*
set directory=~/.vim-tmp/swap/


" # Vim-plug
"
" Installation:
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
" 	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"
" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" https://github.com/itchyny/lightline.vim
Plug 'itchyny/lightline.vim'

" https://github.com/tpope/vim-commentary
Plug 'tpope/vim-commentary'

" https://github.com/tpope/vim-fugitive
Plug 'tpope/vim-fugitive'

" https://github.com/tpope/vim-repeat
Plug 'tpope/vim-repeat'

" https://github.com/tpope/vim-surround
Plug 'tpope/vim-surround'

" https://github.com/tpope/vim-unimpaired
Plug 'tpope/vim-unimpaired'

" https://github.com/tpope/vim-vinegar
Plug 'tpope/vim-vinegar'

" https://github.com/NLKNguyen/papercolor-theme
Plug 'NLKNguyen/papercolor-theme'

" https://github.com/sjl/gundo.vim
Plug 'sjl/gundo.vim'

" https://github.com/airblade/vim-gitgutter
Plug 'airblade/vim-gitgutter'

" Want:
" https://github.com/svermeulen/vim-easyclip

" Initialize plugin system
call plug#end()


syntax enable

" Theming
" if has('nvim')
"     set termguicolors 
" endif
set t_Co=256   " This is may or may not needed.
set background=light
colorscheme PaperColor
let g:lightline = {
      \ 'colorscheme': 'PaperColor_light',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'readonly', 'absolutepath', 'modified' ] ]
      \ }
      \ }

nnoremap <F5> :GundoToggle<CR>
