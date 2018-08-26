" vim: fdm=marker foldenable

""" {{{ PLUGINS
call plug#begin('~/.local/share/nvim/plugged')

" vim-surround: Support for surrounding text with quotes, etc.
Plug 'https://github.com/tpope/vim-surround'

" vim-repeat: Adds repeat support (with .) for plugins
Plug 'https://github.com/tpope/vim-repeat'

" vim-gitgutter: Adds diff signs for git
Plug 'https://github.com/airblade/vim-gitgutter'
set updatetime=100

" vim-fugitive: A git wrapper
Plug 'https://github.com/tpope/vim-fugitive'
"  - :Gdiff
"  - Display git status with :Gstatus
"    - Jump to next file with <C-n>
"    - Toggle staging of file with -
"    - Commit with cc
"  - Run arbitrary git commands with :Git command

" vim-speeddating: Adds inc/dec support for dates
Plug 'https://github.com/tpope/vim-speeddating'
"  - inc with <C-A>
"  - dec with <C-X>
"  - set to current time with d<C-X> (or utc with d<C-A>)

" vim-airline: Better status bar
Plug 'https://github.com/vim-airline/vim-airline'

" terminus: Better integration with the terminal/tmux
Plug 'https://github.com/wincent/terminus'
"  - enables mouse and enables focus reporting (not needed with neovim)
"  - better paste

" syntastic: Syntax checking
Plug 'https://github.com/vim-syntastic/syntastic'
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" rust.vim: Syntax support for rust
Plug 'https://github.com/rust-lang/rust.vim'

" Color scheme
Plug 'https://github.com/altercation/vim-colors-solarized'

call plug#end()

" TODO figure out
"  - vim-surround
"  - syntastic

" TODO check out
"  - https://github.com/Shougo/denite.nvim
"  - https://github.com/neomake/neomake
"  - https://github.com/svermeulen/vim-easyclip
"  - https://github.com/majutsushi/tagbar
"  - https://github.com/lervag/vimtex
"  - https://github.com/junegunn/vim-easy-align
"  - https://github.com/tpope/vim-unimpaired
"  - https://github.com/ctrlpvim/ctrlp.vim
"  - https://github.com/janko-m/vim-test
"  - https://github.com/Valloric/YouCompleteMe

" TODO figure out more in depth
"  - vim-fugitive
""" PLUGINS }}}

""" {{{ COLOR THEME
set background=dark
let g:solarized_termtrans=1
colorscheme solarized
""" COLOR THEME }}}

""" {{{ BASICS
" change the leader key
let mapleader="\<SPACE>"

" always keep another line on screen after tue cursor
set scrolloff=1
""" BASICS }}}

""" {{{ TABS
set expandtab
set tabstop=4
set shiftwidth=4
""" TABS }}}

""" {{{ HIGHLIGHT TABS AND TRAINGING WHITESPACE
" Tell vim what characters to use to highlight there characters
if &listchars ==# 'eol:$'
  set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
endif
set list

" Enable highlighting
highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
match ExtraWhitespace /\s\+$\|\t/
""" HIGHLIGHT TABS AND TRAINGING WHITESPACE }}}

""" {{{ SPLITTING
set splitright
set splitbelow
""" SPLITTING }}}

""" {{{ Searching
set ignorecase
set smartcase

" Use <C-L> to clear the highlighting of :set hlsearch.
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<CR><C-L>
endif

" Search and Replace
nmap <Leader>s :%s//g<Left><Left>
""" SEARCHING }}}

