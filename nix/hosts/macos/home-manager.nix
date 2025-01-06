{ pkgs, user, ... }:

{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;  
    users.${user} = {
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

      home.packages = with pkgs; [
        yabai
        skhd
      ] ++ import ../shared/packages-home.nix { inherit pkgs; };

      home.file = {
        ".config/yabai".source = ../../../home/yabai;
        ".config/skhd".source = ../../../home/skhd;
      } // import ../shared/dotfile-paths.nix {};

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
            # open file descriptor 5 such that anything written to /dev/fd/5
            # is piped through ts and then to /tmp/timestamps
            # exec 5> >(ts -i "%.s" >> /tmp/timestamps)
            # https://www.gnu.org/software/bash/manual/html_node/Bash-Variables.html
            # export BASH_XTRACEFD="5"
            # Enable tracing
            # set -x
            export BASH_SILENCE_DEPRECATION_WARNING=1
            if [ -d "$HOME/.local/bin" ]; then
                PATH="$HOME/.local/bin:$PATH"
            fi
          '';
        };

        nix-index.enable = true;
        nix-index.enableBashIntegration = true;

        neovim = {
          viAlias = true;
          vimAlias = true;
        };
      };
    };
  };
}


