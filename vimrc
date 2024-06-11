" ## Basics: ##

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
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,.DS_Store,.*.un~,**/node_module/,**/.git/

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

set cursorline

set background=light
set noshowmode 
set showcmd
set showtabline=1
set guioptions-=e
set laststatus=2 
if has("nvim")
    set laststatus=3 " Only show statusline at the bottom window
endif

set fileencodings=utf8 enc=utf8
set expandtab tabstop=4 softtabstop=4 shiftwidth=4
set autoindent

set listchars=eol:⏎,tab:▸\ ,trail:·,nbsp:⎵

set autoread
" http://stackoverflow.com/questions/2490227/how-does-vims-autoread-work#20418591
au FocusGained,BufEnter * :silent! !
set hidden

" File safety:
if !isdirectory($HOME . "/.vim-tmp")
    call mkdir($HOME . "/.vim-tmp/backup", "p", 0700)
    call mkdir($HOME . "/.vim-tmp/swap", "p", 0700)
    call mkdir($HOME . "/.vim-tmp/undo-nvim", "p", 0700)
    call mkdir($HOME . "/.vim-tmp/undo-vim", "p", 0700)
endif
set backup
set backupdir=~/.vim-tmp/backup//
if has("persistent_undo")
    set undofile
    if has("nvim")
        set undodir=~/.vim-tmp/undo-nvim//
    else
        set undodir=~/.vim-tmp/undo-vim//
    endif
endif
" If we backup temporary files often automated editing tools like the crontab
" editor get confused
set backupskip=/tmp/*,/private/tmp/*
set directory=~/.vim-tmp/swap//

filetype plugin on
set omnifunc=syntaxcomplete#Complete



" ## Vim-plug ##


let data_dir = '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

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

" tpope fan club
Plug 'tpope/vim-abolish' " better find and replace
Plug 'tpope/vim-characterize' " ga for character inspection
Plug 'tpope/vim-commentary' " comments
Plug 'tpope/vim-dadbod' " db management in vim
Plug 'tpope/vim-dispatch' " async builds
Plug 'tpope/vim-endwise' " complete if, do, def
Plug 'tpope/vim-eunuch' " unix tools
Plug 'tpope/vim-fireplace' " clojure
Plug 'tpope/vim-flagship' " statusline
Plug 'tpope/vim-fugitive' " git
Plug 'tpope/vim-jdaddy' " json aj, gqaj, gqij
Plug 'tpope/vim-ragtag' " html/xml/php/etc
Plug 'tpope/vim-repeat' " make repeat work with other things
Plug 'tpope/vim-rhubarb' " github
Plug 'tpope/vim-rsi' " readline shortcuts
Plug 'tpope/vim-scriptease' " vim plugin creation tools
" Plug 'tpope/vim-sexp-mappings-for-regular-people' 
Plug 'tpope/vim-sleuth' " guess file tab/spaces
Plug 'tpope/vim-surround' " dealing with quotes and brackets
Plug 'tpope/vim-unimpaired' " yox and [x ]x
Plug 'tpope/vim-vinegar' " netrw

Plug 'junegunn/fzf'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/gv.vim'
Plug 'junegunn/vim-easy-align'

Plug 'guns/vim-sexp', { 'commit': '14464d4' }

" https://github.com/NLKNguyen/papercolor-theme
Plug 'NLKNguyen/papercolor-theme', { 'commit': '0cfe64f' }

" https://github.com/airblade/vim-gitgutter
Plug 'airblade/vim-gitgutter', { 'commit': 'e801371' }

Plug 'tommcdo/vim-exchange', { 'commit': 'd6c1e97' }

Plug 'eraserhd/parinfer-rust', {'do': 'cargo build --release'}

Plug 'dln/avro-vim', { 'commit': '3af1c69' }

if has('nvim')
    Plug 'nvim-lua/popup.nvim'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'nvim-telescope/telescope-fzy-native.nvim'

    Plug 'neovim/nvim-lspconfig'
    " TODO: Replace
    Plug 'jose-elias-alvarez/nvim-lsp-ts-utils', { 'commit': '0a6a16e' }

    " This isreaking for some reason
    " Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
    " Plug 'nvim-treesitter/playground'
endif

" Initialize plugin system
call plug#end()


" ## Plugin config ##


let g:goyo_width=130

let g:bookmark_save_per_working_dir = 1
let g:bookmark_sign = '♥'

" avro-vim
au BufRead,BufNewFile *.avdl setlocal filetype=avro-idl

" ## Theming ##

syntax enable
colorscheme PaperColor


" ## Custom and mapping ##

let mapleader = ' '

" Editing
vnoremap <leader>p "_dP
nnoremap <leader>d "_d
vnoremap <leader>d "_d

nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>Y gg"+yG<C-o>

vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Git
nnoremap <leader>gg :Git<CR>
nnoremap <leader>gv :GV<CR>

" Buffers
nnoremap <leader>wq :q<CR>
nnoremap <leader>ww :w<CR>
" Classic buffer switching
nnoremap <leader>wl :ls<CR>:b<space>

" Best of vim vinegar
nnoremap - :Explore<CR>
let g:netrw_banner = 0


" Easily modify vimrc
nmap <leader>vnv :e $MYVIMRC<CR>
nmap <leader>vrc :e ~/.vimrc<CR>
" http://stackoverflow.com/questions/2400264/is-it-possible-to-apply-vim-configurations-without-restarting/2400289#2400289
if has("autocmd")
  augroup myvimrchooks
    au!
    au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc,init.vim nested source $MYVIMRC | echo 'Reloaded vimrc'
  augroup END
endif

function! CssToJs() range
    execute ":silent '<,'>s/;/',/"
    execute ":silent '<,'>s/: /: '/"
    " Convert dashed case to camel as long as it is before the first colon:
    execute ":silent '<,'>s#\\v^([^:]*)-(\\l)#\\1\\u\\2#g"
endfunction
command! -range CssToJs <line1>,<line2>call CssToJs()

function! SqlToDataFrameT() range
    execute ":silent '<,'>s#\\v^( *)#\\1\"#"
    execute ":silent '<,'>s#\\v,#\",#"
endfunction
command! -range SqlToDataFrameT <line1>,<line2>call SqlToDataFrameT()

function! WPComTrunkSaveSendAndTest()
  execute ":w"
  execute ":!( ~/scripts/wppush && ssh wpcom-sandbox 'tmux send-keys run-test ENTER' ) &"
  " execute ":!ssh sandbox 'tmux send-keys run-test ENTER' &"
endfunction
command! WPCom call WPComTrunkSaveSendAndTest()
nmap <leader>wp :call WPComTrunkSaveSendAndTest()<CR>


" Use system dark/light mode on Mac
function! SyncSystemColorScheme(...)
    let s:new_bg = "light"
    if $TERM_PROGRAM ==? "Apple_Terminal"
        let s:mode = systemlist("defaults read -g AppleInterfaceStyle 2&>/dev/null || echo Light")[0]
        if s:mode ==? "Dark"
            let s:new_bg = "dark"
        else
            let s:new_bg = "light"
        endif
    endif
    if &background !=? s:new_bg
        let &background = s:new_bg
    endif
endfunction
call SyncSystemColorScheme()
call timer_start(3000, "SyncSystemColorScheme", {"repeat": -1})


autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab indentkeys-=<:>

autocmd FileType cucumber setlocal foldmethod=indent foldlevel=1

" ## Notes ##

" Change to current directory
" :cd %:h
" In netrw: c
