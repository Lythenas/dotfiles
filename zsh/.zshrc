source ~/.profile

fpath+=~/.zsh/zfunc

# Antigen
source ~/.zsh/antigen.zsh
antigen use oh-my-zsh

# Plugins
antigen bundle common-aliases
antigen bundle git
antigen bundle git-extras
antigen bundle command-not-found
antigen bundle gradle
antigen bundle colored-man-pages
antigen bundle encode64
antigen bundle urltools
antigen bundle jsontools
antigen bundle python
#antigen bundle web-search
antigen bundle djui/alias-tips

# TODO add check for distribution
#antigen bundle archlinux
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

# Zsh
setopt COMPLETE_ALIASES

source $HOME/.zsh/aliases.zsh
source $HOME/.zsh/exports.zsh

# Colorscheme
# Base16 Shell
BASE16_SHELL="$HOME/.base16-manager/chriskempson/base16-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
    eval "$("$BASE16_SHELL/profile_helper.sh")"

export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools:$ANDROID_HOME/emulator
