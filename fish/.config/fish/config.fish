export ANDROID_HOME=/home/ms/Android/Sdk
export EDITOR=nvim
export JAVA_HOME=/usr/lib/jvm/default
export PYTHON3_HOST_PROG=/usr/bin/python3
export PYTHON_HOST_PROG=/usr/bin/python
export VISUAL=nvim

if status --is-interactive
    set BASE16_SHELL "$HOME/.config/base16-shell/"
    source "$BASE16_SHELL/profile_helper.fish"
end

starship init fish | source
