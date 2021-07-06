filetype plugin on
syntax on

let mapleader=" "

call plug#begin('~/.vim/plugged')

Plug 'morhetz/gruvbox'

Plug 'junegunn/fzf', { 'do': { -> fzf#install()  }  }
Plug 'junegunn/fzf.vim'
	let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.7 } }
	let $FZF_DEFAULT_COMMAND='rg --files --hidden -g "!.git" '
	let $FZF_DEFAULT_OPTS='--layout=reverse-list'
	let g:fzf_preview_window = ['right:45%', 'ctrl-/']
	nmap <leader><tab> <plug>(fzf-maps-n)
	nnoremap <C-p> :GFiles<CR>
	nnoremap <silent> <expr> <Leader><Leader> (expand('%') =~ 'coc-explorer' ? "\<c-w>\<c-w>" : '').":Files\<cr>"
	command! -bang -nargs=* Rg
	  \ call fzf#vim#grep(
	  \   'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
	  \   <bang>0)
	nmap <leader>rg :Rg<space>
	nmap <silent> <C-f> :Rg <C-R><C-W><CR>

Plug 'neoclide/coc.nvim', {'branch': 'release', 'do': { -> coc#util#install() }}
	let g:coc_global_extensions = [
		\ 'coc-git',
		\ 'coc-clangd',
		\ 'coc-python',
		\ 'coc-html',
		\ 'coc-json',
		\ 'coc-css',
		\ 'coc-html',
		\ 'coc-prettier',
		\ 'coc-eslint',
		\ 'coc-tsserver',
		\ 'coc-emoji',
		\ 'coc-pairs',
		\ 'coc-sh',
		\ 'coc-explorer',
		\ 'coc-diagnostic',
		\ 'coc-highlight'
		\ ]
	let g:coc_config_file = "$HOME/.config/nvim/coc-settings.json"

	function! s:show_documentation()
		if (index(['vim','help'], &filetype) >= 0)
			execute 'h '.expand('<cword>')
		else
			call CocAction('doHover')
		endif
	endfunction

	autocmd CursorHold * silent call CocActionAsync('highlight')

	command! -nargs=0 Prettier :CocCommand prettier.formatFile
	nmap <leader>p :CocCommand prettier.formatFile<cr>
	nmap <silent> <leader>gd <Plug>(coc-definition)
	nmap <silent> <leader>gi <Plug>(coc-implementation)
	nmap <silent> <leader>su <Plug>(coc-references)
	nnoremap <silent> <leader>k :CocCommand explorer --quit-on-open<cr>
	nnoremap <silent> K :call <SID>show_documentation()<CR>
	nmap <silent> [g <Plug>(coc-diagnostic-prev)
	nmap <silent> ]g <Plug>(coc-diagnostic-next)
	inoremap <silent><expr> <C-j> pumvisible() ? "\<C-n>" : coc#refresh()
	inoremap <silent><expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-h>"
	inoremap <silent><expr> <cr> pumvisible() ?
				\ coc#_select_confirm() :
				\ "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"


Plug 'mhinz/vim-startify'
	" Don't change to directory when selecting a file
	let g:startify_files_number = 5
	let g:startify_change_to_dir = 0
	let g:startify_custom_header = [ ]
	let g:startify_relative_path = 1
	let g:startify_use_env = 1

	function! Listcommits()
		let git = 'git -C ' . getcwd()
		let commits = systemlist(git . ' log --oneline | head -n5')
		let git = 'G'
		return map(commits, '{"line": matchstr(v:val, "\\s\\zs.*"), "cmd": "'. git .' show ". matchstr(v:val, "^\\x\\+") }')
	endfunction
	" Custom startup list, only show MRU from current directory/project
	let g:startify_lists = [
	\  { 'type': 'dir',       'header': [ 'Files in '. getcwd() ] },
	\  { 'type': function('Listcommits'), 'header': [ 'Recent Commits' ] },
	\  { 'type': 'sessions',  'header': [ 'Sessions' ]       },
	\  { 'type': 'bookmarks', 'header': [ 'Bookmarks' ]      },
	\  { 'type': 'commands',  'header': [ 'Commands' ]       },
	\ ]

	let g:startify_bookmarks = [
		\ { 'v': '~/.config/nvim/init.vim' },
		\ { 'z': '~/.zshrc' }
	\ ]
	autocmd User Startified setlocal cursorline
	nmap <leader>st :Startify<cr>

Plug 'Yggdroot/indentLine', { 'on': 'IndentLinesEnable' }
	autocmd! User indentLine doautocmd indentLine Syntax
	let g:indentLine_color_term = 239
	let g:indentLine_color_gui = '#616161'

Plug 'junegunn/rainbow_parentheses.vim'
	augroup rainbow_lisp
	  autocmd!
	  autocmd FileType c,cpp,html,css,javascript RainbowParentheses
	augroup END
	let g:rainbow#pairs = [['(', ')'], ['[', ']']]

Plug 'ntpeters/vim-better-whitespace'
	let g:show_spaces_that_precede_tabs = 1

Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'christoomey/vim-tmux-navigator'
	let g:tmux_navigator_no_mappings = 1
	nnoremap <silent> <C-h> :TmuxNavigateLeft<cr>
	nnoremap <silent> <C-j> :TmuxNavigateDown<cr>
	nnoremap <silent> <C-k> :TmuxNavigateUp<cr>
	nnoremap <silent> <C-l> :TmuxNavigateRight<cr>

Plug 'seushin/42header.vim'
	let g:fortytwoheader_user='seushin'
	let g:fortytwoheader_mail='seushin@student.42seoul.kr'
	nmap <f2> :FortyTwoHeader<CR>

Plug 'vim-airline/vim-airline'
	let g:airline#extensions#tabline#enabled = 1
	let g:airline#extensions#hunks#enabled = 0
	let g:airline#extensions#branch#enabled = 1
	let g:airline_section_c = '%<%F%m %#__accent_red#%{airline#util#wrap(airline#parts#readonly(),0)}%#__restore__#'


Plug 'junegunn/gv.vim'
Plug 'tpope/vim-fugitive'
	nnoremap <leader>gs :Git<CR>gg<c-n>
	nnoremap <leader>d :Gvdiff<CR>
	nnoremap <leader>dg :diffget<CR>
	autocmd FileType git set foldlevel=1

call plug#end()

colorscheme gruvbox
set background=dark

set mouse=a
set guicursor=
set title
set nowrap
set noswapfile
set nobackup
set incsearch
set visualbell
set showmatch
set nu rnu
set signcolumn=yes
set cmdheight=1
set scrolloff=8
set colorcolumn=80
set timeoutlen=300
set list listchars=tab:→\ ,
set clipboard=unnamed
set undofile undodir=$HOME/.config/nvim/undo

set ts=4 sw=4 ai si noexpandtab
augroup indent_list
	autocmd!
	autocmd FileType html,css setlocal ts=2 sw=2 expandtab
	autocmd FileType javascript,yaml setlocal ts=2 sts=2 sw=2 expandtab
	autocmd FileType markdown setlocal wrap colorcolumn=""
augroup END

nnoremap <tab> :bn<CR>
nnoremap <s-tab> :bp<CR>
nnoremap <leader>bd :bd<CR>
nnoremap <leader><CR> :so ~/.config/nvim/init.vim<CR>
