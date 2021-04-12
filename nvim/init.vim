call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-sensible'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'roxma/LanguageServer-php-neovim',  {'do': 'composer install && composer run-script parse-stubs'}
Plug 'gruvbox-community/gruvbox'
Plug 'preservim/nerdtree'
Plug 'junegunn/fzf.vim'
Plug 'vim-airline/vim-airline'
call plug#end()

" gruvbox color scheme
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
colorscheme gruvbox
let g:airline_theme='gruvbox'

" nerdtree
let NERDTreeShowHidden=1
map <C-n> :NERDTreeToggle<cr>
" autoclose if NERDTree is last pane open
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" fzf
set rtp+=/usr/local/opt/fzf
map <C-p> :FZF<cr>

" conquer of completion
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" splits
" move without prefix (just C + hjkl for direction)
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
" new split below or right of current one (makes more sense)
set splitbelow
set splitright

set number " show line numbers
set relativenumber " relative line numbers
set backupcopy=yes
set directory=/tmp
set noerrorbells
set scrolloff=5

