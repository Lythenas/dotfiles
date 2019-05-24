



""" PLUGINS
call plug#begin('~/.local/share/nvim/plugged')

" Easy align
" :EasyAlign
" vipga=
Plug 'junegunn/vim-easy-align'
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" Fuzzy finder (FZF)
" [Base plugin already installed using arch]
" :Files :Colors etc.
Plug 'junegunn/fzf.vim'

" Surround
" cs"' ds" ysiw] vS}
Plug 'tpope/vim-surround'

" LSP
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
let g:LanguageClient_autoStart = 1
let g:LanguageClient_serverCommands = {
    \ 'rust': ['rustup', 'run', 'stable', 'rls'],
    \ 'haskell': ['hie-wrapper'],
    \ }
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
Plug '~/Repositories/gnvim-lsp'

" Status line
 Plug 'itchyny/lightline.vim'
set laststatus=2
set noshowmode

call plug#end()
""" END PLUGINS

set hidden
set tabstop=4
set shiftwidth=4
set expandtab
