" Set options required for Vundle
set nocompatible " Vim settings over vi defaults
filetype off

" Fire up Vundle
set rtp+=~/.dotfiles/vim/bundle/vundle/
call vundle#begin()

Plugin 'ludovicchabant/vim-gutentags'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'vim-syntastic/syntastic'
Plugin 'tpope/vim-vinegar'

call vundle#end()

" vim-gutentags
let g:gutentags_cache_dir = '~/.vim/gutentags'

" ctrlp
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

" syntastic
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_php_checkers=['php']
let g:syntastic_check_on_wq = 0

" Set more options
set backspace=indent,eol,start " Make backspace behave in a sane manner.
set number " Add line numbers
set relativenumber " Relative numbers by default
set hlsearch " Highlight search results
set tabstop=4 " Tab size to 4 spaces
set ignorecase " Default to ignoring case in searches
set incsearch " Enable incremental search by default
set autoindent " Auto indent new lines
set smartindent " .. and be smart with it!
set backupcopy=yes
set directory=/tmp " don't pollute working directory with swap files
set noerrorbells " disable error bells
set wildmenu
set wildmode=longest:full,full " wildmenu and friends
set scrolloff=5 " leave 5 lines of space horizontal scrolling

" Switch syntax highlighting on
syntax on

" Enable file type detection and do language-dependent indenting.
filetype plugin indent on
