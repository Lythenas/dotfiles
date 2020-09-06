" vim: ft=vim et fdm=marker

set nocompatible

" PLUGINS {{{
call plug#begin('~/.local/share/nvim/plugged')
Plug 'tpope/vim-sensible'

" For speed
" only update folds when needed
Plug 'Konfekt/FastFold'

" For color/visuals
Plug 'chriskempson/base16-vim'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'RRethy/vim-hexokinase', { 'do': 'make hexokinase' }
Plug 'Konfekt/FoldText'

" For status line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" For features
" NOTE: needs pip3 install --user pynvim
Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }

" Editing
Plug 'reedes/vim-litecorrect'
Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-surround'
Plug 'tomtom/tcomment_vim'
Plug 'christoomey/vim-titlecase'
"
Plug 'mbbill/undotree'

" For Git
" signcolumn
Plug 'mhinz/vim-signify'
" management
Plug 'tpope/vim-fugitive'
" commit browser
Plug 'junegunn/gv.vim'

" For IDE features
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" For languages
Plug 'godlygeek/tabular' " needed for markdown and generally good
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
Plug 'sheerun/vim-polyglot'
Plug 'elzr/vim-json'
Plug 'ron-rs/ron.vim'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'

" Vimwiki
Plug 'lervag/wiki.vim'
Plug 'gyim/vim-boxdraw'

call plug#end()
" PLUGINS }}}

filetype plugin indent on

" GENERAL SET-TINGS {{{
set updatetime=300
" disable message for ins-completion-menu
set shortmess+=c
" always show signcolumn
set signcolumn=yes
" show line numbers
set number
set relativenumber
" search is only case sensitive when there is an upper case character
set smartcase
" better indentation
set autoindent
"set smartindent
" enable mouse support everywhere
set mouse=a
" better tabs (default to 2 spaces for indentation, but display existing tabs
" as 8 spaces)
set expandtab
set tabstop=8
set shiftwidth=4
set softtabstop=4
" better cmdline completion
set wildmode=longest:full,full
set wildignorecase
set wildmenu
"
set cursorline
set colorcolumn=80,100
" better colors in terminal
set termguicolors
" display some (probably unwanted) invisible characters
set list
" GENERAL SET-TINGS }}}

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

" use ripgrep to list files (respects .gitignore)
call denite#custom#var('file/rec', 'command', ['rg', '--files', '--glob', '!.git'])
" use ripgrep in place of grep
"  - search hidden and case insensitively if pattern is all lowercase
call denite#custom#var('grep', 'command', ['rg'])
call denite#custom#var('grep', 'default_opts', ['--hidden', '--vimgrep', '--heading', '-S'])

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

" SNIPPETS {{{

" SNIPPETS }}}

" IDE FEATURES (coc) {{{
let g:coc_global_extensions = [ 'coc-json', 'coc-rust-analyzer', 'coc-css', 'coc-vimlsp',
                              \ 'coc-clangd', 'coc-cmake',
                              \ 'coc-svg', 'coc-emmet', 'coc-python',
                              \ 'coc-yaml', 'coc-html', 'coc-docker',
                              \ 'coc-sh', 'coc-markdownlint',
                              \ 'coc-lists', 'coc-yank', 'coc-ultisnips']
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
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" do code action in selected region
" e.g. <leader>aap for current paragraph
xmap <leader>a <Plug>(coc-codeaction-selected)
nmap <leader>a <Plug>(coc-codeaction-selected)

" auto fix problem on current line
nmap <leader>qf <Plug>(coc-fix-current)

" use tab to select range (needs server support)
" TODO needs different key bindings and also in visual mode
" xmap <silent> <TAB> <Plug>(coc-range-select)
" nmap <silent> <TAB> <Plug>(coc-range-select)
" xmap <silent> <S-TAB> <Plug>(coc-range-select-backword)

" format
xmap <leader>f <Plug>(coc-format-selected)
nmap <leader>f <Plug>(coc-format-selected)

" TODO
" organize imports

" shortcuts to coc lists:
nnoremap <silent> <leader>a :<C-u>CocList diagnostics<cr>
nnoremap <silent> <leader>c :<C-u>CocList commands<cr>
nnoremap <silent> <leader>o :<C-u>CocList outline<cr>
" workspace symbols
nnoremap <silent> <leader>s :<C-u>CocList -I symbols<cr>
" do default action for next/prev item
nnoremap <silent> <leader>j :<C-u>CocNext<cr>
nnoremap <silent> <leader>k :<C-u>CocNext<cr>
" bring up last list
nnoremap <silent> <leader>p :<C-u>CocListResume<cr>


" IDE FEATURES }}}

" GIT GUTTER {{{
" use '[c' and ']c' to navigate hunks
let g:signify_update_on_focusgained = 1
" GIT GUTTER }}}

" WIKI {{{
let g:wiki_root = '~/wiki'
let g:wiki_filetypes = ['md', 'wiki']
let g:wiki_link_target_type = 'md'
" let g:wiki_mappings_use_defaults = 'local'
" WIKI }}}

" MISC IMPROVEMENTS {{{

" move selected lines in visual mode
vnoremap J :m '>+1<CR>gv
vnoremap K :m '<-2<CR>gv

" easier window switching
nmap <C-h> <C-W>h
nmap <C-J> <C-W>j
nmap <C-k> <C-W>k
nmap <C-l> <C-W>l

" make substitution repeat to reuse last flags
nnoremap & :&&<cr>
xnoremap & :&&<cr>

" highlight matches when jumping to next
nnoremap <silent> n n:call HLNext(0.2)<cr>
nnoremap <silent> N N:call HLNext(0.2)<cr>

" function! HLNext (blinktime)
"     highlight BlackOnBlack ctermfg=black ctermbg=black guibg=bg guifg=bg
"     let [bufnum, lnum, col, off] = getpos('.')
"     let matchlen = strlen(matchstr(strpart(getline('.'), col-1), @/))
"     let hide_pat = '\%<'.lnum.'l.'
"             \ . '\|'
"             \ . '\%'.lnum.'l\%<'.col.'v.'
"             \ . '\|'
"             \ . '\%'.lnum.'l\%>'.(col+matchlen-1).'v.'
"             \ . '\|'
"             \ . '\%>'.lnum.'l.'
"     let ring = matchadd('BlackOnBlack', hide_pat, 101)
"     redraw
"     exec 'sleep ' .float2nr(a:blinktime * 1000) . 'm'
"     call matchdelete(ring)
"     redraw
" endfunction

function! HLNext (blinktime)
    highlight HLNext gui=bold,underline,standout guifg=white guibg=black
    let [bufnum, lnum, col, off] = getpos('.')
    let matchlen = strlen(matchstr(strpart(getline('.'), col-1), @/))
    let target_pat = '\c\%#'.@/
    let ring = matchadd('HLNext', target_pat, 101)
    redraw
    exec 'sleep ' . float2nr(a:blinktime * 1000) . 'm'
    call matchdelete(ring)
    redraw
endfunction

" MISC_IMPROVEMENTS }}}

" VIM MAPPING REMINDER {{{
"
" Commenting:
"  > tcomment
" gcc gc{motion} g>{motion} g<{motion}
"
" Titlecaseing:
"  > titlecase
" gt{motion} gT
"
" Undotree:
"  > undotree.txt
" :UndotreeToggle
"
" VIM MAPPING REMINDER }}}
