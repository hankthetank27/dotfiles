# Dotfiles #
My config files and scripts.

## Install with Nix ##

Install nix
```
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```

Run "nix switch" script for your system
```
# macos aarch-64
nix-switch-aarch64-darwin.sh
```

## Install from script ##

### Requirements ###
* NeoVim v0.11.0
* tmux v3.0a
* kitty v0.33.0
* skhd v0.3.9 (MacOS)
* yabai v7.5.1 (MacOS)

### Installation ###
Run `install.sh`. You can use the `--overwrite` or `-o` argument to overwrite files or directories in the install paths.
