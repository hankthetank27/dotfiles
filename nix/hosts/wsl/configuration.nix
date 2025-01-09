{
  user,
  system,
  fenix,
  pkgs,
  inputs,
  ...
}:
{
  users.users.${user} = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "docker"
    ];
    # FIXME: add your own hashed password
    # hashedPassword = "";
    # FIXME: add your own ssh public key
    # openssh.authorizedKeys.keys = [
    #   "ssh-rsa ..."
    # ];
  };

  imports = [
    ./home.nix
  ];

  nixpkgs = {
    overlays = [ fenix.overlays.default ];
  };

  environment = {
    systemPackages = [ ] ++ import ../shared/packages-config.nix { inherit pkgs fenix system; };
    shells = [ pkgs.bash ];
    enableAllTerminfo = true;
    variables = {
      # SHELL = "${pkgs.bashInteractive}/bin/bash";
      EDITOR = "vim";
    };
  };

  security.sudo.wheelNeedsPassword = false;

  # services.openssh.enable = true;

  system.stateVersion = "22.05";

  wsl = {
    enable = true;
    wslConf.automount.root = "/mnt";
    wslConf.interop.appendWindowsPath = false;
    wslConf.network.generateHosts = false;
    defaultUser = "${user}";
    startMenuLaunchers = true;

    # Enable integration with Docker Desktop (needs to be installed)
    docker-desktop.enable = false;
  };

  # virtualisation.docker = {
  #   enable = true;
  #   enableOnBoot = true;
  #   autoPrune.enable = true;
  # };

  # FIXME: uncomment the next block to make vscode running in Windows "just work" with NixOS on WSL
  # solution adapted from: https://github.com/K900/vscode-remote-workaround
  # more information: https://github.com/nix-community/NixOS-WSL/issues/238 and https://github.com/nix-community/NixOS-WSL/issues/294
  # systemd.user = {
  #   paths.vscode-remote-workaround = {
  #     wantedBy = ["default.target"];
  #     pathConfig.PathChanged = "%h/.vscode-server/bin";
  #   };
  #   services.vscode-remote-workaround.script = ''
  #     for i in ~/.vscode-server/bin/*; do
  #       if [ -e $i/node ]; then
  #         echo "Fixing vscode-server in $i..."
  #         ln -sf ${pkgs.nodejs_18}/bin/node $i/node
  #       fi
  #     done
  #   '';
  # };

  programs.ssh.startAgent = true;

  nix = {
    settings = {
      trusted-users = [
        "root"
        "${user}"
        "@wheel"
      ];
      # FIXME: use your access tokens from secrets.json here to be able to clone private repos on GitHub and GitLab
      # access-tokens = [
      #   "github.com=${secrets.github_token}"
      #   "gitlab.com=OAuth2:${secrets.gitlab_token}"
      # ];

      accept-flake-config = true;
      auto-optimise-store = true;
    };

    registry = {
      nixpkgs = {
        flake = inputs.nixpkgs;
      };
    };

    nixPath = [
      "nixpkgs=${inputs.nixpkgs.outPath}"
      "nixos-config=/etc/nixos/configuration.nix"
      "/nix/var/nix/profiles/per-user/root/channels"
    ];

    package = pkgs.nixVersions.stable;
    extraOptions = ''experimental-features = nix-command flakes'';

    gc = {
      automatic = true;
      options = "--delete-older-than 30d";
    };
  };
}
