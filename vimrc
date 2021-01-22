set nocompatible
filetype plugin on
syntax on

set guicursor=
set nu rnu
set incsearch
set visualbell
set showmatch
set scrolloff=8
set ts=4 sw=4 ai si noexpandtab

set title
set nowrap
set noswapfile
set nobackup
set clipboard=unnamed
set mouse=

let mapleader=" "
let maplocalleader=" "

call plug#begin('~/.vim/plugged')
Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-commentary'
Plug 'junegunn/fzf', { 'do': { -> fzf#install()  }  }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'valloric/youcompleteme'
Plug 'tpope/vim-surround'
" Plug 'stsewd/fzf-checkout.vim'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'
Plug 'ntpeters/vim-better-whitespace'
	let g:show_spaces_that_precede_tabs=1
call plug#end()

colorscheme gruvbox
set background=dark
set cmdheight=2 colorcolumn=80

" windcmd
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
nnoremap <leader>+ :vertical resize +5<CR>
nnoremap <leader>- :vertical resize -5<CR>
nnoremap <leader>pv :wincmd v<bar> :Ex <bar> :vertical resize 30<CR>
nnoremap <leader><CR> :so ~/.config/nvim/init.vim<CR>

" buffers
nnoremap <tab> :bn<CR>
nnoremap <s-tab> :bp<CR>
nnoremap <leader>bd :bd<CR>

" vim-airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#hunks#enabled = 0
let g:airline#extensions#branch#enabled=1
"let g:airline_section_c = '%{fnamemodify(resolve(expand("%:p")),":~")}'
let g:airline_section_c = '%<%F%m %#__accent_red#%{airline#util#wrap(airline#parts#readonly(),0)}%#__restore__#'

" fzf
let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8 } }
let $FZF_DEFAULT_OPTS='--reverse'
let g:fzf_preview_window = ['right:50%', 'ctrl-/']
nmap <leader><tab> <plug>(fzf-maps-n)
nnoremap <Leader><C-p> :GFiles<CR>
nnoremap <Leader>pf :Files<CR>

" YouCompleteMe
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
let g:ycm_confirm_extra_conf = 0
let g:ycm_key_list_select_completion = ['<C-j>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-k>', '<Up>']
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_min_num_of_chars_for_completion = 1
let g:ycm_auto_trigger = 0
let g:ycm_python_binary_path = '/Library/Frameworks/Python.framework/Versions/3.8/bin/python3'
nnoremap <leader>t :YcmCompleter GetType<CR>

"" fzf-checkout
"nnoremap <leader>gc :GCheckout<CR>

"" fugitive
"nmap <leader>gj :diffget //3<CR>
"nmap <leader>gf :diffget //2<CR>
"nmap <leader>gs :G<CR>
nmap <leader>g :Gstatus<CR>gg<c-n>
nnoremap <leader>d :Gdiff<CR>
autocmd FileType git set foldlevel=1
