{
  pkgs,
  user,
  # lib,
  ...
}:
let
  utils = import ../../utils { inherit pkgs; };
in
{
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
          utils.makeScriptsFromDir ../../../bin
          ++ import ../shared/packages-home.nix { inherit pkgs; };

        home.file = { } // import ../shared/dotfile-paths.nix { };

        home.sessionVariables = {
          EDITOR = "${pkgs.neovim}/bin/nvim";
          # SHELL = "${pkgs.bashInteractive}/bin/bash";
        };

        fonts.fontconfig.enable = true;

        # trying to launch ssh-agent on startup
        xdg.configFile."environment.d/ssh-agent.conf" = {
          text = ''
            SSH_AUTH_SOCK=$XDG_RUNTIME_DIR/ssh-agent
          '';
        };

        programs = {
          # Let Home Manager install and manage itself.
          home-manager.enable = true;

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

          tmux = {
            enable = true;
            plugins = with pkgs; [
              tmuxPlugins.sensible
            ];
            extraConfig =
              ''
                set -g default-terminal "xterm-256color"
                set-option -ga terminal-overrides ",xterm-256color:Tc"
              ''
              + builtins.readFile ../../../home/.tmux.conf;
          };
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
