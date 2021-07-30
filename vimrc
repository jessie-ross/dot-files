" Basics:
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set viminfo='20,\"1024
set history=200
set ruler

set hlsearch incsearch ignorecase smartcase
set showmatch

" set autochdir

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

" set splitbelow
" set splitright

set scrolloff=10
"set colorcolumn=81

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
" Run :PlugInstall to install these
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

" https://github.com/nvim-telescope/telescope.nvim
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

Plug 'neovim/nvim-lspconfig'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update

Plug 'jose-elias-alvarez/nvim-lsp-ts-utils'

" Want:
" https://github.com/svermeulen/vim-easyclip

" Initialize plugin system
call plug#end()



" Theming
" if has('nvim')
"     set termguicolors 
" endif
syntax enable
colorscheme PaperColor
set t_Co=256   " This is may or may not needed.
set background=light
let g:lightline = {
      \ 'colorscheme': 'PaperColor_light',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'readonly', 'absolutepath', 'modified' ] ]
      \ }
      \ }
" set cursorline
set noshowmode showcmd
" StatusLine always visible, display full path
" http://learnvimscriptthehardway.stevelosh.com/chapters/17.html
set laststatus=2 statusline=%F

nnoremap <F5> :GundoToggle<CR>


" Easily modify vimrc 
nmap <leader>v :e $MYVIMRC<CR>
" http://stackoverflow.com/questions/2400264/is-it-possible-to-apply-vim-configurations-without-restarting/2400289#2400289
if has("autocmd")
  augroup myvimrchooks
    au!
    au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc,init.vim nested source $MYVIMRC | lua print('Reloaded vimrc')
    call lightline#enable()
  augroup END
endif 

function! CssToJs() range
    execute ":silent '<,'>s/;/',/"
    execute ":silent '<,'>s/: /: '/"
    " Convert dashed case to camel as long as it is before the first colon:
    execute ":silent '<,'>s#\\v^([^:]*)-(\\l)#\\1\\u\\2#g"
endfunction
command! -range CssToJs <line1>,<line2>call CssToJs()
