" vim: fdm=marker foldenable

""" {{{ INFO
" Plugins are loaded with the internal package loader (like in Vim8).
" See |packages|
"
" Since there are no actual vim packages (only plugins) the folder structure
" is as follows:
"
" $ tree ~/.local/share/nvim/site/pack
" ~/.local/share/nvim/site/pack
" ├── colorschemes
" │   └── opt
" ├── trying-out
" │   ├── opt
" │   └── start
" └── using
"     ├── opt
"     └── start
"
" Plugins are git repositories and are managed as submodules in my dotfiles
" repository. To update them simply run `git submodule update --remote` in the
" dotfiles clone.
""" INFO }}}

" enable mouse in all modes
set mouse=a

" enable solarized color theme
set background=dark
let g:solarized_termtrans=1
colorscheme solarized


