export PATH=$HOME/bin:$HOME/.cargo/bin:$PATH

# Antigen
source ~/.zsh/antigen.zsh
antigen use oh-my-zsh

# Plugins
antigen bundle common-aliases
antigen bundle git
antigen bundle git-extras
antigen bundle comman-not-found
antigen bundle gradle
antigen bundle colored-man-pages
antigen bundle encode64
antigen bundle urltools
antigen bundle jsontools
antigen bundle python
#antigen bundle web-search
antigen bundle djui/alias-tips

# TODO add check for distribution
antigen bundle archlinux
#antigen bundle dnf
#antigen bundle suse

# fish like look and behavior
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-history-substring-search

# better colors for ls
antigen bundle HeroCC/LS_COLORS

# easily extract archives with 'extract ...'
antigen bundle extract

# better ctrl-z support for vim
antigen bundle alexrochas/zsh-vim-crtl-z
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z

# Theme
antigen theme ys

antigen apply

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=10'

# Zsh
setopt COMPLETE_ALIASES

source $HOME/.zsh/aliases.zsh
source $HOME/.zsh/exports.zsh
