alias mdpreview="grip --user=lythenas --pass=4b38fb1a43278005d79e1fc7ab4205e52f12adde"

alias ls="ls --color=auto"

alias c='clear'

# Repeat last command with sudo
alias please='sudo $(fc -nl -1)'

# Verbose output for chmod and chown
alias chmod='chmod -v'
alias chown='chown -v'

# Print formatted path
alias path='echo -e ${PATH//:/\\n}'

# Make mkdir create parent folders automatically and output ever folder created
alias mkdir='mkdir -pv'

alias toclip='xclip -sel clipboard'

# Make Alacritty start with XWayland
# alias walacritty='env WAYLAND_DISPLAY= alacritty'
