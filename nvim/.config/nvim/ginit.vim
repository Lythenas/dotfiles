""" gui
if exists('g:GtkGuiLoaded')
    set rtp+=/usr/share/nvim-gtk/runtime/
    silent! source 'nvim_gui_shim.vim'
    let g:GuiInternalClipboard=1 
    call rpcnotify(1, 'Gui', 'Font', 'Iosevka 14')
    call rpcnotify(1, 'Gui', 'FontFeatures', 'XHS0') " enable ligatures for haskell
    " TODO call this when a specific file is displayed
    colorscheme evening
endif
