# Dotfiles

My dotfiles are managed by [stow](https://www.gnu.org/software/stow/) (see http://brandon.invergo.net/news/2012-05-26-using-gnu-stow-to-manage-your-dotfiles.html for a good explanation).

## Installation and Usage

I prefer to clone this repo to `~/dotfiles` but you could choose a different location.

1. `git clone https://github.com/Lythenas/dotfiles ~/dotfiles`
1. `cd ~/dotfiles`
1. run `stow $package` for every `$package` you want to use the config (you still have to install the package from your package manager)

## Included Configs

### Vim

I use the native package manager of vim 8 (see https://shapeshed.com/vim-packages/ for a description). This means that all vim packages are git repositories themselves and are included as submodules in this repository. Before you can use any of the packages you need to run `git submodule init && git submodule update --remote`. To update the submodules use `git submodule update --remote` in this repository.

Install with `stow vim`.

### Neovim

I use [Plug](https://github.com/junegunn/vim-plug) to manage my nvim plugins. All plugins are configured in `.config/nvim/init.vim` and are downloaded with `:PlugInstall` in nvim.

Install with `stow nvim`.

### Alacritty

[Alacritty](https://github.com/jwilm/alacritty) is a terminal emulator written in rust. I use it in combination with tmux to enable mouse scrolling.

Install with `stow alacritty`.

### ZSH

I use zsh instead of bash.

Install with `stow zsh`.

### tmux

[tmux](https://github.com/tmux/tmux) is a terminal multiplexer. I use it to not have to open up multiple terminal windows.

Install with `stow tmux`.
