""" gui
" TODO configure nvom-gtk instead of gnvim
"if exists('gnvim')
"    "call gnvim#cursor_tooltip#hide()
"    nnoremap <silent> <ESC> :call gnvim#cursor_tooltip#hide()<CR>
"endif
if exists('g:GtkGuiLoaded')
    set rtp+=/usr/share/nvim-gtk/runtime/
    silent! source 'nvim_gui_shim.vim'
    let g:GuiInternalClipboard=1 
    call rpcnotify(1, 'Gui', 'Font', 'Iosevka 14')
    call rpcnotify(1, 'Gui', 'FontFeatures', 'XHS0') " enable ligatures for haskell
    colorscheme evening
endif
