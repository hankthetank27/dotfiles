# Dotfiles #
My config files and scripts.

## Install with Nix ##

#### Install Nix
```
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```

#### Make scripts executable
```
find nix/scripts/$(uname -m | sed 's/arm64/aarch64/')-darwin -type f \( -name build -o -name build-switch \) -exec chmod +x {} \;
```

#### Install configuration
Ensure the build works before deploying the configuration, run
```
nix run .#build
```

#### Build system
Alter your system with this command:
```
nix run .#build-switch
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
