" vim: fdm=marker foldenable

" toggle one fold under cursor with za
" open all folds with zR, close all folds with zM

""" {{{ INFO
" Plugins are loaded via the Vim internal package loader (as of version 8).
" See :help packages
"
" The folder structure is as follows:
" ~/.vim/pack
"     colorschemes/opt
"     using
"         opt
"         start
"     trying-out
"         opt
"         start
"
" Colorschemes are in colorschemes/opt. They are loaded automatically when
" calling :colorscheme somtehing.
"
" Plugins that are just being tested are in trying-out/opt and
" trying-out/start.
"
" The other plugins are in using/opt and using/start.
"
" PLugins in the */start/* folders are loaded as usual.
" E.g. */start/*/plugin/*.vim are loaded when vim starts.
"      */start/*/syntax/*.vim are loaded when the syntax is needed.
"      etc.
" Plugins in the */opt/* folders are not loaded automatically (use the
" packadd! somtehing command to load a plugin.
"
" Plugins are downloaded and kept up-to-date with git. A update script is
" coming soon.
"
""" INFO }}}

" {{{ BASIC SETUP
set nocompatible
set encoding=utf-8
filetype plugin indent on
syntax enable

" Solarized Color Scheme
set background=dark
let g:solarized_termtrans=1
colorscheme solarized

" Modelines (Comments at top of file e.g. # vim: ...)
set modelines=2 " only check top 2 lines
set modeline

" Splits
set splitright

" send more characters for redraws
set ttyfast

" Enable mouse in all modes
set mouse=a
"set ttymouse=xterm2

" add support for '%' to jumpt to html-tags, etc.
packadd! matchit

" BASIC SETUP }}}

""" {{{ PLUGIN CONFIGURATION

""" Git Gutter

set updatetime=250

""" Markdown

" disable folding
"let g:vim_markdown_folding_disabled = 1
" auto-fit the table of contents window (opened with :Toc)
let g:vim_markdown_toc_autofit = 1
" disable conceal (dont hide formatting syntax)
let g:vim_markdown_conceal = 0
let g:tex_conceal = ""
" enable LaTeX syntax in markdown
let g:vim_markdown_math = 1
" follow links to other markdown files with 'ge' (does not require .md in
" the link)
let g:vim_markdown_follow_anchor = 1
let g:vim_markdown_no_extensions_in_markdown = 1

""" Airline (statusbar)

" better font (icons) and the nice rectangle/arrow reparators
let g:airline_powerline_fonts = 1

" define symbols
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_symbols.linenr = ''
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.notexists = '∄'

" define sections content
" +---------------------------------------------+
" | A | B |         C        X | Y | Z |  [...] |
" +---------------------------------------------+
"let g:airline_section_a = ''
"let g:airline_section_b = airline#section#create(['hunks'])
"let g:airline_section_c = ''
"let g:airline_section_gutter = ''
"let g:airline_section_x = ''
"let g:airline_section_y = ''
"let g:airline_section_z = ''
"let g:airline_section_error = ''
"let g:airline_section_warning = ''


" PLUGIN CONFIGURATION }}}

" {{{ FILE FINDING

" Search down into subfolders
set path+=**
" display matches when tab completing in cmd mode
set wildmenu
" allow wildcards e.g. *
set wildmode=longest:full,full

" :find <filename in path> opens file in new buffer
" -> :find <TAB> tab completion
"    :find * fuzzy find
" :b <buffername> displays buffer with name <buffername>
" -> :b <TAB> tab completion
" in insert mode:
"  - ^x^n for just this file autocompletion
"  - ^x^f for filenames autocompletion
"  - ^n switch back
"  - ^p forth in suggestion list

" file browsing
"let g:netrw_banner=0
let g:netrw_browser_split=4   " open in previous window
let g:netrw_altv=1            " open splits to the right
let g:netrw_liststyle=3       " tree view
let g:netrw_list_hide=netrw_gitignore#Hide()
"let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'

" FILE FINDING }}}

" {{{ TABS = 4 SPACES!!!!
set softtabstop=0 " always 0. otherwise comibnation of spaces and tabs will be used (BAD)
set expandtab " inserts spaces when pressing tab
set shiftwidth=4 " num spaces to insert for one tab
set smarttab " if there are already spaces after the cursor jump to them instead of inserting new ones
" }}}

" {{{ SEARCH
set ignorecase smartcase

" enable search highlighting
set hlsearch

" add shortcut to turn search highlighting off
nnoremap <F3> :noh<RETURN>

" SEARCH }}}

" {{{ SPLITS
" more natural splits
set splitbelow
set splitright

" shortcuts for navigation splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" SPLITS }}}

" {{{ SINPPETS

" TODO
" Example:
" nnoremap ,html :-1read $HOME/.vim/snippets/skeleton.html<CR>

" SNIPPETS }}}

" {{{ OTHER

" show relative line numbers on the left
set nonumber
set relativenumber

" mark two or more spaces after some text as an error
syntax match DoubleSpace /\S\zs {2,}/
highlight link DoubleSpace Error

" OTHER }}}

