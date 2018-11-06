# Dotfiles

My dotfiles are managed by [stow](https://www.gnu.org/software/stow/) (see http://brandon.invergo.net/news/2012-05-26-using-gnu-stow-to-manage-your-dotfiles.html for a good explanation).

## Installation and Usage

I prefer to clone this repo to `~/dotfiles` but you could choose a different location.

1. `git clone https://github.com/Lythenas/dotfiles ~/dotfiles`
1. `cd ~/dotfiles`
1. run `stow $package` for every `$package` you want to use the config (you still have to install the package from your package manager)

## Included Configs

### Vim / Neovim

I use SpaceVim with my own configuration for both vim and nvim.

Vim needs version >8 and `+python3`.

Install with `stow spacevim`.

I kepts my old nvim config in this repo. Install them with `stow nvim`. **Note:** you should probably not use both configurations at the same time.

### Alacritty

[Alacritty](https://github.com/jwilm/alacritty) is a terminal emulator written in rust. I use it in combination with tmux to enable mouse scrolling.

Install with `stow alacritty`.

### ZSH

I use zsh instead of bash.

Install with `stow zsh`.

### tmux

[tmux](https://github.com/tmux/tmux) is a terminal multiplexer. I use it to not have to open up multiple terminal windows.

Install with `stow tmux`.
