# Dotfiles

My dotfiles are managed by [stow](https://www.gnu.org/software/stow/) (see http://brandon.invergo.net/news/2012-05-26-using-gnu-stow-to-manage-your-dotfiles.html for a good explanation).

## Installation and Usage

I prefer to clone this repo to `~/dotfiles` but you could choose a different location.

1. `git clone https://github.com/Lythenas/dotfiles ~/dotfiles`
1. `cd ~/dotfiles`
1. run `stow $package` for every `$package` you want to use the config

## Included Configs

### Vim

I use the native package manager of vim 8 (see https://shapeshed.com/vim-packages/ for a description). This means that all vim packages are git repositories themselves and are included as submodules in this repository. To update those packages you can `cd` into their directories and `git pull` manually. Or to update all of them at once use `git submodule update --remote`.

