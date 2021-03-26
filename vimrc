" Refer: https://github.com/junegunn/dotfiles
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
set list lcs=tab:\|\ ,

let mapleader=" "
let maplocalleader=" "

call plug#begin('~/.vim/plugged')
Plug 'morhetz/gruvbox'

Plug 'vim-airline/vim-airline'
	let g:airline#extensions#tabline#enabled = 1
	let g:airline#extensions#hunks#enabled = 0
	let g:airline#extensions#branch#enabled=1
	let g:airline_section_c = '%<%F%m %#__accent_red#%{airline#util#wrap(airline#parts#readonly(),0)}%#__restore__#'

Plug 'junegunn/fzf', { 'do': { -> fzf#install()  }  }
Plug 'junegunn/fzf.vim'
	let g:fzf_layout = { 'down': '30%' }
	let $FZF_DEFAULT_OPTS='--reverse'
	let g:fzf_preview_window = ['right:50%', 'ctrl-/']
	nmap <leader><tab> <plug>(fzf-maps-n)
	nnoremap <Leader><C-p> :GFiles<CR>
	nnoremap <silent> <expr> <Leader><Leader> (expand('%') =~ 'NERD_tree' ? "\<c-w>\<c-w>" : '').":Files\<cr>"

Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install() }}
	if has_key(g:plugs, 'coc.nvim')
		inoremap <silent><expr> <C-j> pumvisible() ? "\<C-n>" : coc#refresh()
		inoremap <silent><expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-h>"
		inoremap <silent><expr> <cr> pumvisible() ?
					\ coc#_select_confirm() :
					\ "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
		let g:coc_global_extensions = ['coc-git', 'coc-clangd', 'coc-python',
			\ 'coc-html', 'coc-json', 'coc-css', 'coc-html', 'coc-java',
			\ 'coc-prettier', 'coc-eslint', 'coc-tsserver', 'coc-emoji']
		command! -nargs=0 Prettier :CocCommand prettier.formatFile
		augroup coc-config
			autocmd!
			autocmd VimEnter * nmap <silent> <leader>gd <Plug>(coc-definition)
			autocmd VimEnter * nmap <silent> <leader>gi <Plug>(coc-implementation)
			autocmd VimEnter * nmap <silent> <leader>su <Plug>(coc-references)
		augroup END
	endif

Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
	augroup nerd_loader
		autocmd!
		autocmd VimEnter * silent! autocmd! FileExplorer
		autocmd BufEnter,BufNew *
			\  if isdirectory(expand('<amatch>'))
			\|   call plug#load('nerdtree')
			\|   execute 'autocmd! nerd_loader'
			\| endif
	augroup END
	nnoremap <leader>n :NERDTreeToggle<cr>
Plug 'ryanoasis/vim-devicons'

Plug 'Yggdroot/indentLine', { 'on': 'IndentLinesEnable' }
	let g:indentLine_setColors = 0
	let g:indentLine_char = '|'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/rainbow_parentheses.vim'
	augroup rainbow_lisp
	  autocmd!
	  autocmd FileType c,cpp RainbowParentheses
	augroup END
	let g:rainbow#pairs = [['(', ')'], ['[', ']']]
Plug 'ntpeters/vim-better-whitespace'
	let g:show_spaces_that_precede_tabs=1

Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
	nmap <leader>gs :Gstatus<CR>gg<c-n>
	nnoremap <leader>d :Gvdiff<CR>
	autocmd FileType git set foldlevel=1
Plug 'junegunn/gv.vim'

Plug 'pandark/42header.vim'
	let g:fortytwoheader_user='seushin'
	let g:fortytwoheader_mail='seushin@student.42seoul.kr'
	nmap <f2> :FortyTwoHeader<CR>
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
