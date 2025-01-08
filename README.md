# Dotfiles #
My config files and scripts.

## Install ##

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
