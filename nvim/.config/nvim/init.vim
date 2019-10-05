syntax on
filetype plugin indent on

set nocompatible
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

" colorscheme darkblue
" hi Keyword ctermfg=darkcyan
" hi Constant ctermfg=5*
" hi Comment ctermfg=2*
" hi Normal ctermbg=none
" hi LineNr ctermfg=darkgrey

""" PLUGINS
call plug#begin('~/.local/share/nvim/plugged')

" Status line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
"set laststatus=2
set noshowmode
" :AirlineExtensions

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

" Completion
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
let g:deoplete#enable_at_startup = 1

Plug 'lighttiger2505/deoplete-vim-lsp'
Plug 'tbodt/deoplete-tabnine', { 'do': './install.sh' }

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

" JSON
Plug 'elzr/vim-json'

" Markdown
" Plug 'plasticboy/vim-markdown'
" let g:vim_markdown_folding_disabled = 1
" let g:vim_markdown_conceal = 0
" let g:tex_conceal = ""
" let g:vim_markdown_math = 1
" " support all front matters as to not get syntax errors
" let g:vim_markdown_frontmatter = 1 " for YAML format
" let g:vim_markdown_toml_frontmatter = 1 " for TOML format
" let g:vim_markdown_json_frontmatter = 1 " for JSON format

" Pandoc
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'

let g:pandoc#folding#mode = 'stacked'
let g:pandoc#syntax#conceal#use = 0

Plug 'vim-latex/vim-latex'

" LSP
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'vhakulinen/gnvim-lsp'

" folding
set foldmethod=expr
  \ foldexpr=lsp#ui#vim#folding#foldexpr()
  \ foldtext=lsp#ui#vim#folding#foldtext()

" signs
let g:lsp_signs_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1

" current configs require the pwd to be the root of the project
if executable('rls')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'rls',
        \ 'cmd': {server_info->['rustup', 'run', 'stable', 'rls']},
        \ 'workspace_config': {'rust': {'clippy_preference': 'on'}},
        \ 'whitelist': ['rust'],
        \ })
endif

if executable('hie-wrapper')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'hie',
        \ 'cmd': {server_info->['hie-wrapper']},
        \ 'whitelist': ['haskell', 'hs', 'lhs'],
        \ })
endif

" Autocomplete
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
let g:deoplete#enable_at_startup = 1

" Lint display
Plug 'w0rp/ale'
let g:ale_linters = {'haskell': ['hie', 'hlint', 'stack_build', 'stack_ghc']}
let g:ale_fixers = {'*': ['trim_whitespace'], 'haskell': ['hlint']}

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
