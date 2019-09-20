# Dotfiles

My dotfiles are managed by [stow](https://www.gnu.org/software/stow/) (see http://brandon.invergo.net/news/2012-05-26-using-gnu-stow-to-manage-your-dotfiles.html for a good explanation).

## Installation and Usage

I prefer to clone this repo to `~/dotfiles` but you could choose a different location.

1. `git clone https://github.com/Lythenas/dotfiles ~/dotfiles`
1. `cd ~/dotfiles`
1. run `stow $package` for every `$package` you want to use the config (you still have to install the package from your package manager)

## Included Configs

### Vim / Neovim

Includes (most) nvim-gtk configs.

Install with `stow nvim`.

### Alacritty

[Alacritty](https://github.com/jwilm/alacritty) is a terminal emulator written in rust. I use it in combination with tmux to enable mouse scrolling.

Install with `stow alacritty`.

### ZSH

I used zsh. Currently I use fish.

Install with `stow zsh`.

### fish

My shell.

Install with `stow fish`.

### tmux

[tmux](https://github.com/tmux/tmux) is a terminal multiplexer. I use it to not have to open up multiple terminal windows.

Install with `stow tmux`.

### Xmonad

[xmonad](https://xmonad.org/) is a tiling window manager written and configured in haskell.

Install with `stow xmonad`.

Requires xmonad, xmonad-contrib, xmobar (compiled with flag all_extensions), trayer, dmenu-launch, clipit, deadd-notification-center
