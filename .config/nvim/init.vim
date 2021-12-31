"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-plug settings and plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" install vim-plug if not already installed
if empty(glob("~/.config/nvim/autoload/plug.vim"))
	execute '!curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.github.com/junegunn/vim-plug/master/plug.vim'
endif

call plug#begin('~/.config/nvim/plugged')

" uber-necessary plugins
Plug 'neoclide/coc.nvim', {'branch': 'release'}			" auto-complete
Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}	" file browsing
Plug 'vim-airline/vim-airline'							" better status bar

Plug 'preservim/tagbar'									" tags

Plug 'sheerun/vim-polyglot'								" language syntax highlighting?
Plug 'vim-syntastic/syntastic'							" syntax checking

" aesthetics
Plug 'veloce/vim-aldmeris'					" Oblivion color scheme
Plug 'ryanoasis/vim-devicons'

call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" general
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
colorscheme aldmeris

" next two commands called by vim-plug, being redundant to ensure
filetype plugin indent on|	" file type detection, indent and plugin loading based on file type
syntax enable|	" syntax highlighting

set backspace=indent,eol,start|	" make backspace work properly
"set cmdheight=2|
set cursorline|	" highlight current line
set encoding=utf-8|	" all is right in the world
set fileformat=unix|	" now all is right in the world
set foldenable|	" enable code folding
set foldmethod=syntax|	" fold code based on syntax
set hidden|	" modified buffers don't need to be saved before switching
set history=1000|	" larger command history
set ignorecase|	" ignore case when searching
set laststatus=2|	" show status line even when only 1 window is present
set linebreak|	" break lines intelligently
set number|	" line numbering (for when in insert mode)
set relativenumber|	" relative line numbering
set ruler
set showcmd|	" show command keys pressed so far
set wildmenu

set scrolloff=999|						" keep cursor in center of screen (mostly)
set shiftwidth=4|	" only auto-indent 4 columns
set tabstop=4|	" 4-space tabs
"set textwidth=0|	" disable line wrapping by

" relative line numbers in normal mode, absolute in insert mode
autocmd InsertLeave,BufEnter,FocusGained * :set relativenumber
autocmd InsertEnter,BufLeave,FocusLost * :set norelativenumber

"let g:python3_host_prog = '/usr/bin/python3'

" disable arrow keys in normal mode
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

" disable arrow keys in insert mode
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" general key mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" move up lines graphically, good for long lines
nmap j gj
" move down lines graphically, good for long lines
nmap k gk
" toggle word wrap
nmap <Leader>wr :call ToggleWrap()<CR>
" toggle whitespace display
nmap <Leader>ws :call ToggleWhitespace()<CR>
" close buffer without closing window
nmap <Leader>q :bp<bar>sp<bar>bn<bar>bd<CR>
" close preview window
nmap <Leader>p :pc<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" custom functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" toggle view all whitespace
set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣
:function ToggleWhitespace()
:	if (&list == 1)
:		set nolist
:	else
:		set list
:	endif
:endfunction

" toggle word wrap
:function ToggleWrap()
:	if (&wrap == 1)
:		set nowrap
:	else
:		set wrap
:	endif
:endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" coc.nvim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" declare CoC extensions
let g:coc_global_extensions = [
			\ 'coc-pyright',
			\ 'coc-rust-analyzer'
			\ ]

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
			\ pumvisible() ? "\<C-n>" :
			\ <SID>check_back_space() ? "\<TAB>" :
			\ coc#refresh()
"inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
" the following two lines allow tabs at the end of words instead of searching
" completion candidates
" sources for fix: 
" https://github.com/neoclide/coc.nvim/wiki/Completion-with-sources#improve
" https://bleepcoder.com/coc-nvim/421789422/issue-on-pressing-tab-at-the-end-of-a-word
" https://vi.stackexchange.com/questions/32983/cant-enter-a-tab-character-when-previous-character-is-not-a-tab-or-space-in-ins/33080
inoremap <expr><Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr><S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NERDTree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" toggle tree
nmap <Leader>d :NERDTreeToggle<CR>
" close Neovim if the only window left open is NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
" inclease default NERDTree width
let NERDTreeWinSize=50

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" syntastic
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatusLineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_python_checkers = ['pylint']
let g:syntastic_python_pylint_args = '--disable=bad-whitespace'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-airline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:airline_powerline_fonts=1					" use fonts with special characters (patched Powerline fonts)
let g:airline#extensions#tabline#enabled = 1	" allow extensions to use airline

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-polyglot
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" python
let g:python_highlight_all = 1
" rust seems to need nothing

