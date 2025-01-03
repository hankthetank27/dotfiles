{ config, pkgs, user, ... }:

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

      # The home.packages option allows you to install Nix packages into your
      # environment.
      home.packages = [
        pkgs.yabai
        pkgs.skhd

        # # It is sometimes useful to fine-tune packages, for example, by applying
        # # overrides. You can do that directly here, just don't forget the
        # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
        # # fonts?
        # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

        # # You can also create simple shell scripts directly inside your
        # # configuration. For example, this adds a command 'my-hello' to your
        # # environment:
        # (pkgs.writeShellScriptBin "my-hello" ''
        #   echo "Hello, ${config.home.username}!"
        # '')
      ] ++ import ./shared/packages.nix { inherit pkgs; };

      home.file = {
        ".config/yabai".source = ../../home/yabai;
        ".config/skhd".source = ../../home/skhd;

      } // import ./shared/dotfile-paths.nix {};

      # Home Manager can also manage your environment variables through
      # 'home.sessionVariables'. These will be explicitly sourced when using a
      # shell provided by Home Manager. If you don't want to manage your shell
      # through Home Manager then you have to manually source 'hm-session-vars.sh'
      # located at either
      #
      #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
      #
      # or
      #
      #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
      #
      # or
      #
      #  /etc/profiles/per-user/hjackson/etc/profile.d/hm-session-vars.sh
      #
      home.sessionVariables = {
        EDITOR = "vim";
      };

      # Let Home Manager install and manage itself.
      programs.home-manager.enable = true;
    };
  };
}


