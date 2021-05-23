" General {{{
	set nocompatible
	filetype plugin on
	syntax on

	let mapleader=" "
	let maplocalleader=" "

	set guicursor=
	set nu rnu
	set incsearch
	set visualbell
	set showmatch

	set title
	set nowrap
	set noswapfile
	set nobackup
	set clipboard=unnamed
	set mouse=a

	set list
	set listchars=tab:→\ ,

	set signcolumn=yes " always show signcolumn
	set cmdheight=1 colorcolumn=80
	set scrolloff=8

	set ts=4 sw=4 ai si noexpandtab
	augroup indent_list
		autocmd!
		autocmd FileType html,css setlocal ts=2 sw=2 expandtab
		autocmd FileType javascript setlocal ts=2 sts=2 sw=2 expandtab
	augroup END

	" windcmd {{{
		nnoremap <leader>+ :vertical resize +5<CR>
		nnoremap <leader>- :vertical resize -5<CR>
		nnoremap <leader><CR> :so ~/.config/nvim/init.vim<CR>
	" }}}

	" buffers {{{
		nnoremap <tab> :bn<CR>
		nnoremap <s-tab> :bp<CR>
		nnoremap <leader>bd :bd<CR>
	" }}}
" }}}

" vim-plug {{{
	call plug#begin('~/.vim/plugged')

	" colorscheme
	Plug 'morhetz/gruvbox'

	" General plugin {{{
		Plug 'tpope/vim-commentary'
		Plug 'tpope/vim-surround'
		Plug 'junegunn/vim-peekaboo'
		Plug 'ryanoasis/vim-devicons'
		Plug 'christoomey/vim-tmux-navigator'
			let g:tmux_navigator_no_mappings = 1
			nnoremap <silent> <C-h> :TmuxNavigateLeft<cr>
			nnoremap <silent> <C-j> :TmuxNavigateDown<cr>
			nnoremap <silent> <C-k> :TmuxNavigateUp<cr>
			nnoremap <silent> <C-l> :TmuxNavigateRight<cr>
		Plug 'preservim/vimux'
			nmap <leader>vp :VimuxPromptCommand<CR>
			nmap <silent> <leader>vq :VimuxCloseRunner<CR>

		Plug 'pandark/42header.vim'
			let g:fortytwoheader_user='seushin'
			let g:fortytwoheader_mail='seushin@student.42seoul.kr'
			nmap <f2> :FortyTwoHeader<CR>
	" }}}

	" vim-airline {{{
		Plug 'vim-airline/vim-airline'
			let g:airline#extensions#tabline#enabled = 1
			let g:airline#extensions#hunks#enabled = 0
			let g:airline#extensions#branch#enabled=1
			let g:airline_section_c = '%<%F%m %#__accent_red#%{airline#util#wrap(airline#parts#readonly(),0)}%#__restore__#'
	" }}}

	" fzf {{{
		Plug 'junegunn/fzf', { 'do': { -> fzf#install()  }  }
		Plug 'junegunn/fzf.vim'
			let g:fzf_layout = { 'down': '30%' }
			let $FZF_DEFAULT_OPTS='--reverse'
			let g:fzf_preview_window = ['right:50%', 'ctrl-/']
			nmap <leader><tab> <plug>(fzf-maps-n)
			nnoremap <Leader><C-p> :GFiles<CR>
			nnoremap <silent> <expr> <Leader><Leader> (expand('%') =~ 'coc-explorer' ? "\<c-w>\<c-w>" : '').":Files\<cr>"
	" }}}

	" coc {{{
		Plug 'neoclide/coc.nvim', {'branch': 'release', 'do': { -> coc#util#install() }}
		if has_key(g:plugs, 'coc.nvim')
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
			let g:coc_config_file="$HOME/.config/nvim/coc-settings.json"

			inoremap <silent><expr> <C-j> pumvisible() ? "\<C-n>" : coc#refresh()
			inoremap <silent><expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-h>"
			inoremap <silent><expr> <cr> pumvisible() ?
						\ coc#_select_confirm() :
						\ "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

			nmap <silent> <leader>k :CocCommand explorer --quit-on-open<cr>

			" Use K to show documentation in preview window
			nnoremap <silent> K :call <SID>show_documentation()<CR>
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

			nmap <silent> [c <Plug>(coc-diagnostic-prev)
			nmap <silent> ]c <Plug>(coc-diagnostic-next)
		endif
	" }}}

	" Startify: Fancy startup screen for vim {{{
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
				\ { 'c': '~/.vimrc' },
				\ { 'z': '~/.zshrc' }
			\ ]

			autocmd User Startified setlocal cursorline
			nmap <leader>st :Startify<cr>
		" }}}

	" Appearance {{{
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
			let g:show_spaces_that_precede_tabs=1
	" }}}

	" git {{{
		Plug 'tpope/vim-fugitive'
			nmap <leader>gs :Gstatus<CR>gg<c-n>
			nnoremap <leader>d :Gvdiff<CR>
			autocmd FileType git set foldlevel=1
		Plug 'junegunn/gv.vim'
	" }}}
	"
	call plug#end()
" }}}

" colorscheme {{{
	colorscheme gruvbox
	set background=dark
" }}}
