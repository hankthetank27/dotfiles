# Dotfiles #
My config files and scripts.

## Install on MacOS ##

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

## Install on NixOS for WSL ##

#### Install NixOS distro for WSL
```
https://nix-community.github.io/NixOS-WSL/install.html
```

#### Set username and install Git
In `/etc/nixos/configuration.nix` add 
```
environment.systemPackages = [ git ];
```
and follow this guide to update username
```
https://nix-community.github.io/NixOS-WSL/how-to/change-username.html
```


#### Install configuration
Clone repo, and cd into it.
Ensure the build works before deploying the configuration, run
```
sudo nixos-rebuild --flake .#wsl test
```

#### Build system
Alter your system with this command:
```
sudo nixos-rebuild --flake .#wsl switch
```
