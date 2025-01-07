{ pkgs, user, ... }:

{
  homebrew = {
    enable = true;
    casks = pkgs.callPackage ./casks.nix { };
    # onActivation.cleanup = "uninstall";

    # These app IDs are from using the mas CLI app
    # mas = mac app store
    # https://github.com/mas-cli/mas
    #
    # $ nix shell nixpkgs#mas
    # $ mas search <app name>
    #
    # If you have previously added these apps to your Mac App Store profile (but not installed them on this system),
    # you may receive an error message "Redownload Unavailable with This Apple ID".
    # This message is safe to ignore. (https://github.com/dustinlyons/nixos-config/issues/83)
    # masApps = {
    #   "1password" = 1333542190;
    #   "wireguard" = 1451685025;
    # };
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.${user} =
      { ... }:
      {

        # Home Manager needs a bit of information about you and the paths it should
        # manage.

        # This value determines the Home Manager release that your configuration is
        # compatible with. This helps avoid breakage when a new Home Manager release
        # introduces backwards incompatible changes.
        #
        # You should not change this value, even if you update Home Manager. If you do
        # want to update the value, then make sure to first check the Home Manager
        # release notes.
        home.stateVersion = "24.11"; # Please read the comment before changing.

        home.packages =
          with pkgs;
          [
            yabai
            skhd
          ]
          ++ import ../shared/packages-home.nix { inherit pkgs; };

        home.file = {
          ".config/yabai".source = ../../../home/yabai;
          ".config/skhd".source = ../../../home/skhd;
        } // import ../shared/dotfile-paths.nix { };

        home.sessionVariables = {
          EDITOR = "${pkgs.neovim}/bin/nvim";
          # SHELL = "${pkgs.bashInteractive}/bin/bash";
        };

        programs = {
          # Let Home Manager install and manage itself.
          home-manager.enable = true;

          # kitty.enable = true;
          bash = {
            enable = true;
            profileExtra = ''
              export BASH_SILENCE_DEPRECATION_WARNING=1
              if [ -d "$HOME/.local/bin" ]; then
                  PATH="$HOME/.local/bin:$PATH"
              fi
            '';
          };

          nix-index = {
            enable = true;
            enableBashIntegration = true;
          };

          neovim = {
            enable = true;
            viAlias = true;
            vimAlias = true;
            vimdiffAlias = true;
            withNodeJs = true;
          } // import ../shared/packages-nvim.nix { inherit pkgs; };
        };

        xdg.configFile."nvim" = {
          recursive = true;
          source = ../../../editor/nvim;
        };

        xdg.configFile."nvim/parser".source =
          let
            parsers = pkgs.symlinkJoin {
              name = "treesitter-parsers";
              paths = pkgs.vimPlugins.nvim-treesitter.withAllGrammars.dependencies;
            };
          in
          "${parsers}/parser";
      };
  };
}
