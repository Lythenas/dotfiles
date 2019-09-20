syntax on
filetype plugin indent on

set nocompatible
set number
set showmode
set smartcase
set smarttab
set smartindent
set autoindent
set expandtab
set shiftwidth=2
set softtabstop=2
set background=dark
set laststatus=0
set mouse=a

" colorscheme darkblue
hi Keyword ctermfg=darkcyan
hi Constant ctermfg=5*
hi Comment ctermfg=2*
hi Normal ctermbg=none
hi LineNr ctermfg=darkgrey

""" PLUGINS
call plug#begin('~/.local/share/nvim/plugged')

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
set hidden
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
let g:LanguageClient_autoStart = 1
let g:LanguageClient_serverCommands = {
    \ 'rust': ['rustup', 'run', 'stable', 'rls'],
    \ }
    " \ 'haskell': ['hie-wrapper', '--lsp'],
let g:LanguageClient_rootMarkers = ['*.cabal', 'stack.yaml']
function LC_maps()
    if has_key(g:LanguageClient_serverCommands, &filetype)
	nnoremap <F5> :call LanguageClient_contextMenu()<CR>
	" Or map each action separately
	" nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
	" nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
	" nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
    endif
endfunction
autocmd FileType * call LC_maps()

let g:LanguageClient_trace = "verbose"
let g:LanguageClient_windowLogMessageLevel = "Log"
let g:LanguageClient_loggingLevel = 'DEBUG'
let g:LanguageClient_loggingFile = expand('~/LanguageClient.log')
let g:LanguageClient_serverStderr = expand('~/LanguageClient-stderr.log')

Plug '~/Repositories/gnvim-lsp'

" Autocomplete
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
let g:deoplete#enable_at_startup = 1

" Lint display
Plug 'w0rp/ale'
let g:ale_linters = {'haskell': ['hie', 'hlint', 'stack_build', 'stack_ghc']}
let g:ale_fixers = {'*': ['trim_whitespace'], 'haskell': ['hlint']}

" Status line
 Plug 'itchyny/lightline.vim'
set laststatus=2
set noshowmode

" Git gutter
Plug 'airblade/vim-gitgutter'

" Tabular
" allign blocks of code
Plug 'godlygeek/tabular'
nnoremap <leader>= :Tabularize /=<CR>
nnoremap <leader>- :Tabularize /-><CR>
nnoremap <leader>, :Tabularize /,<CR>
nnoremap <leader># :Tabularize /#-}<CR>

call plug#end()
""" END PLUGINS

