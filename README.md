# svhl/scripts

Scripts I use that I couldn't find anywhere else. Some are modified from others' scripts.

## Scripts

### [logout](https://github.com/svhl/scripts/tree/main/logout.sh)
Prevent a logout app icon from sometimes appearing in the taskbar on KDE Plasma when calling the logout screen with ctrl+alt+del. Tested on Plasma 5.27.

### [vim](https://github.com/svhl/scripts/tree/main/vim)

A wrapper script to automatically use sudo when opening root-owned files and prevent you from vimming into directories. Based on [vim-auto-sudo](https://github.com/n3b0j5a/vim-auto-sudo).

### [git](https://github.com/svhl/scripts/tree/main/git)

A wrapper script to shorten a few long Git commands.

#### `copy`

Simplify cloning a repo.\
Usage: `git copy [user]/[repo] [branch]`

#### `sync`

Set remote repo. Token needs to be set in `GIT_TOKEN` environment variable.\
Usage: `git sync [user]/[repo]`

#### `undo`

Undo the last commit and remove from history.\
Usage: `git undo`

## How to use

Make scripts executable with `chmod +x [script]`. Move wrapper scripts to `~/.local/bin/`. 
