syntax on
filetype plugin indent on

set nocompatible
set hidden
set updatetime=300
set shortmess+=c
set signcolumn=yes
set number
set smartcase
set smarttab
set smartindent
set autoindent
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set laststatus=0
set mouse=a
set colorcolumn=80,100
set termguicolors

" colorscheme darkblue
" hi Keyword ctermfg=darkcyan
" hi Constant ctermfg=5*
" hi Comment ctermfg=2*
" hi Normal ctermbg=none
hi LineNr ctermfg=darkgrey
" set background=dark
colorscheme evening

""" PLUGINS
call plug#begin('~/.local/share/nvim/plugged')

" Status line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
"set laststatus=2
set noshowmode
" :AirlineExtensions
let g:airline#extensions#coc#enabled = 1


let g:airline_theme='deus'
set background=dark
set laststatus=2

" defaults for terminal nvim
colorscheme default

" overwrite defaults for gui nvim
function! s:ui_enter()
  if get(v:event, "chan") == 1
    colorscheme evening
    set guifont=Iosevka:h16
    set linespace=2
  endif
endfunction

au UIEnter * call s:ui_enter()

" Denite
Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }

" Defx Filebrowser
Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
" TODO

" Better writing support
Plug 'reedes/vim-litecorrect'

augroup litecorrect
  autocmd!
  autocmd FileType markdown,md,mkd,pandoc call litecorrect#init()
augroup END

" Goyo + Limelight
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'

let g:limelight_conceal_ctermfg = 'gray'

autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

" Easy align
" :EasyAlign
" vipga=
Plug 'junegunn/vim-easy-align'
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" Fuzzy finder (FZF)
" [Base plugin already installed using arch]
" :Files :Colors etc.
" NOTE: install fzf using the distro package manager
Plug 'junegunn/fzf.vim'

" Surround
" cs"' ds" ysiw] vS}
Plug 'tpope/vim-surround'

""" LANGUAGES
Plug 'sheerun/vim-polyglot'
let g:polyglot_disabled = []

" JSON
Plug 'elzr/vim-json'
autocmd FileType json syntax match Comment +\/\/.\+$+

" Pandoc
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'

let g:pandoc#folding#mode = 'stacked'
let g:pandoc#syntax#conceal#use = 0

Plug 'vim-latex/vim-latex'

" IDE features
Plug 'neoclide/coc.nvim', {'branch': 'release'}
let g:coc_global_extensions = [ 'coc-json', 'coc-rls', 'coc-css', 'coc-vimlsp',
                              \ 'coc-svg', 'coc-emmet', 'coc-python',
                              \ 'coc-yaml', 'coc-html', 'coc-docker',
                              \ 'coc-sh', 'coc-markdownlint',
                              \ 'coc-lists', 'coc-yank',
                              \ 'coc-highlight']
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

Plug 'Shougo/echodoc.vim'
let g:echodoc#enable_at_startup = 1
let g:echodoc#type = 'echo'
"let g:echodoc#type = 'floating'
"highlight link EchoDocFloat Pmenu

" Git gutter
" Plug 'airblade/vim-gitgutter'
Plug 'mhinz/vim-signify'
" let g:signify_line_highlight = 1
" let g:signify_update_on_bufenter = 1
let g:signify_update_on_focusgained = 1

" highlight lines in Sy and vimdiff etc.)
highlight DiffAdd           cterm=bold ctermbg=none ctermfg=119 gui=bold guibg=none guifg=#87ff5f
highlight DiffDelete        cterm=bold ctermbg=none ctermfg=167 gui=bold guibg=none guifg=#df5f5f
highlight DiffChange        cterm=bold ctermbg=none ctermfg=227 gui=bold guibg=none guifg=#ffff5f

" highlight signs in Sy
highlight SignifySignAdd    cterm=bold ctermbg=237  ctermfg=119 gui=bold guibg=#3a3a3a guifg=#87ff5f
highlight SignifySignDelete cterm=bold ctermbg=237  ctermfg=167 gui=bold guibg=#3a3a3a guifg=#df5f5f
highlight SignifySignChange cterm=bold ctermbg=237  ctermfg=227 gui=bold guibg=#3a3a3a guifg=#ffff5f

highlight SignColumn ctermbg=none cterm=none guibg=none gui=none

highlight link SignifySignAdd             SignifySignAdd
highlight link SignifySignChange          SignifySignChange
highlight link SignifySignDelete          SignifySignDelete

" Tabular
" allign blocks of code
Plug 'godlygeek/tabular'
nnoremap <leader>= :Tabularize /=<CR>
nnoremap <leader>- :Tabularize /-><CR>
nnoremap <leader>, :Tabularize /,<CR>
nnoremap <leader># :Tabularize /#-}<CR>

call plug#end()
""" END PLUGINS
