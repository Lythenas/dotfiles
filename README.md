# Dotfiles

My dotfiles are managed by [stow](https://www.gnu.org/software/stow/) (see http://brandon.invergo.net/news/2012-05-26-using-gnu-stow-to-manage-your-dotfiles.html for a good explanation).

## Installation and Usage

I prefer to clone this repo to `~/dotfiles` but you could choose a different location.

1. `git clone https://github.com/Lythenas/dotfiles ~/dotfiles`
1. `cd ~/dotfiles`
1. run `stow $package` for every `$package` you want to use the config

## Included Configs

### Vim

I use the native package manager of vim 8 (see https://shapeshed.com/vim-packages/ for a description). This means that all vim packages are git repositories themselves and are included as submodules in this repository. Before you can use any of the packages you need to run `git submodule init && git submodule update --remote`. To update the submodules use `git submodule update --remote` in this repository.

## Alacritty

[Alacritty](https://github.com/jwilm/alacritty) is a terminal emulator written in rust. I use it in combination with tmux to enable mouse scrolling.

