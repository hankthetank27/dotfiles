{
  self,
  pkgs,
  user,
  system,
  fenix,
  ...
}:

{
  users.users.${user} = {
    name = "${user}";
    home = "/Users/${user}";
  };

  imports = [
    ./home.nix
  ];

  # The platform the configuration will be used on.
  nixpkgs = {
    hostPlatform = {
      inherit system;
    };

    overlays = [ fenix.overlays.default ];

    config = {
      allowUnfree = true;
      # cudaSupport = true;
      # cudaCapabilities = ["8.0"];
      allowBroken = true;
      allowInsecure = false;
      allowUnsupportedSystem = true;
    };
  };

  environment = {
    # List packages installed in system profile. To search by name, run:
    # $ nix-env -qaP | grep wget
    systemPackages = [ ] ++ import ../shared/packages-config.nix { inherit pkgs fenix system; };

    variables = {
      # SHELL = "${pkgs.bashInteractive}/bin/bash";
      EDITOR = "vim";
    };

  };
  # Necessary for using flakes on this system.
  nix.settings = {
    experimental-features = "nix-command flakes";

    trusted-users = [
      "root"
      "${user}"
      "@wheel"
    ];
  };

  programs.ssh.startAgent = true;

  services = {
    yabai = {
      enable = true;
      package = pkgs.yabai;
      enableScriptingAddition = true;
    };

    skhd = {
      enable = true;
      package = pkgs.skhd;
    };
  };

  system = {
    stateVersion = 5;

    # Set Git commit hash for darwin-version.
    configurationRevision = self.rev or self.dirtyRev or null;

    defaults = {
      NSGlobalDomain = {
        AppleShowAllExtensions = true;
        ApplePressAndHoldEnabled = false;

        KeyRepeat = 2; # Values: 120, 90, 60, 30, 12, 6, 2
        InitialKeyRepeat = 15; # Values: 120, 94, 68, 35, 25, 15

        "com.apple.mouse.tapBehavior" = 1;
        "com.apple.sound.beep.volume" = 0.0;
        "com.apple.sound.beep.feedback" = 0;
      };

      dock = {
        autohide = false;
        show-recents = false;
        launchanim = true;
        orientation = "right";
        tilesize = 38;
      };
    };
  };
}
