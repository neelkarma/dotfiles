# dotfiles

> My personal dotfiles.

Note: This is just my method of backing up my dotfiles - not really intended for others to use. If you do, however, want to use these, here's how:

1. Install GNU Stow.
1. Clone this repository **into a subdirectory of your home directory (important!)**. So, the repository should be located at `/home/{username}/dotfiles`.
1. `cd` into the repository and run `stow .`.
1. To "uninstall", run `stow -D .`
