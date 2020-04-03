" vim: fdm=marker

" GENERAL SET-TINGS {{{
syntax on
filetype plugin indent on

set nocompatible
set updatetime=300
" disable message for ins-completion-menu
set shortmess+=c
" always show signcolumn
set signcolumn=yes
" show line numbers
set number
" search is only case sensitive when there is an upper case character
set smartcase
" better indentation
set smartindent
set autoindent
" enable mouse support everywhere
set mouse=a
" better tabs
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set smarttab
" better cmdline completion
set wildmode=longest:full
set wildignorecase
set wildmenu
"
set colorcolumn=80,100
" better colors in terminal
set termguicolors
" }}}

" PLUGINS {{{
call plug#begin('~/.local/share/nvim/plugged')
Plug 'chriskempson/base16-vim'
" Status line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" NOTE: needs pip3 install --user pynvim
Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
" only update folds when needed
Plug 'Konfekt/FastFold'
Plug 'reedes/vim-litecorrect'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
" Color previews
Plug 'RRethy/vim-hexokinase', { 'do': 'make hexokinase' }
Plug 'junegunn/vim-easy-align'
" NOTE: install fzf using the distro package manager
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-surround'
" Languages
Plug 'sheerun/vim-polyglot'
Plug 'elzr/vim-json'
Plug 'ron-rs/ron.vim'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'vim-latex/vim-latex'
" IDE features
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Git gutter
Plug 'mhinz/vim-signify'
" Git management
Plug 'tpope/vim-fugitive'
" Git commit browser
Plug 'junegunn/gv.vim'

call plug#end()
" PLUGINS }}}

" COLORSCHEME AND HIGHLIGHTING {{{
" colorscheme
set background=dark
let base16colorspace=256
colorscheme base16-default-dark

" highlight trailing whitespace
highlight link ExtraWhitespace Error
match ExtraWhitespace /\s\+$/
" COLORSCHEME AND HIGHLIGHTING }}}

" AIRLINE {{{
set laststatus=2
set noshowmode

let g:airline_skip_empty_sections = 1
" let g:airline_highlighting_cache = 1
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
" only load these extensions (see :AirlineExtensions for a list of extensions)
let g:airline#extensions#disable_rtp_load = 1
let g:airline_extensions = [
      \'branch',
      \'coc',
      \'denite',
      \'fugitiveline',
      \'hunks',
      \'netrw',
      \'quickfix',
      \'tabline',
      \'term',
      \'whitespace',
      \'wordcount']
" TODO grepper, nerdtree, nrrwrgn, po, poetv, vimtex, vista
let g:airline#extensions#branch#format = 2
let g:airline#extensions#whitespace#mixed_indent_algo = 1

" Make tab switchable by number using e.g. <leader>1
let g:airline#extensions#tabline#buffer_idx_mode = 1
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9
nmap <leader>- <Plug>AirlineSelectPrevTab
nmap <leader>+ <Plug>AirlineSelectNextTab

" remove and change some symbols
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.linenr = ''
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.branch = '⎇ '
let g:airline_symbols.whitespace = 'Ξ '
let g:airline_left_sep = ''
let g:airline_right_sep = ''

" AIRLINE }}}

" DENITE {{{
" Setup keybindings
" <CR> do_action
"
autocmd FileType denite call s:denite_my_settings()
function! s:denite_my_settings() abort
  nnoremap <silent><buffer><expr> <CR>    denite#do_map('do_action')
  nnoremap <silent><buffer><expr> p       denite#do_map('do_action', 'preview')
  nnoremap <silent><buffer><expr> q       denite#do_map('quit')
  nnoremap <silent><buffer><expr> <Esc>   denite#do_map('quit')
  nnoremap <silent><buffer><expr> i       denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> <Space> denite#do_map('toggle_select').'j'
endfunction

autocmd FileType denite-filter call s:denite_filter_my_settings()
function! s:denite_filter_my_settings() abort
  imap <silent><buffer> <C-o> <Plug>(denite_filter_quit)
endfunction

call denite#custom#var('file/rec', 'command', ['rg', '--files', '--glob', '!.git'])

" DENITE }}}

" DEFX {{{
" TODO
" DEFX }}}

" FASTFOLD {{{
" TODO nrrwrgn, (sessions)
" FASTFOLD }}}

" LIGHTCORRECT {{{
augroup litecorrect
  autocmd!
  autocmd FileType markdown,md,mkd,pandoc call litecorrect#init()
augroup END
" LITECORRECT }}}

" GOYO {{{
let g:limelight_conceal_ctermfg = 'gray'

autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!
" GOYO }}}

" HEXOKINASE {{{
let g:Hexokinase_highlighters = ['virtual']
" HEXOKINASE }}}

" EASYALIGN {{{
" :EasyAlign
" vipga=
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)
" EASYALIGN }}}

" SURROUND {{{
" cs"' ds" ysiw] vS}
" SURROUND }}}

" LANGUAGES {{{
let g:polyglot_disabled = []

" JSON
autocmd FileType json syntax match Comment +\/\/.\+$+

" PANDOC
let g:pandoc#folding#mode = 'stacked'
let g:pandoc#syntax#conceal#use = 0
" LANGUAGES }}}

" IDE FEATURES (coc) {{{
let g:coc_global_extensions = [ 'coc-json', 'coc-rls', 'coc-css', 'coc-vimlsp',
                              \ 'coc-svg', 'coc-emmet', 'coc-python',
                              \ 'coc-yaml', 'coc-html', 'coc-docker',
                              \ 'coc-sh', 'coc-markdownlint',
                              \ 'coc-lists', 'coc-yank']
" other lsps configured in :CocConfig

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
" autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
" IDE FEATURES }}}

" GIT GUTTER {{{
" use '[c' and ']c' to navigate hunks
let g:signify_update_on_focusgained = 1
" GIT GUTTER }}}

