{ pkgs, ... }:
with pkgs;

{
  extraPackages = [
    # Telescope
    ripgrep
    # treesitter
    gcc
  ];

  plugins = with pkgs.vimPlugins; [
    lazy-nvim
  ];

  extraLuaConfig =
    let
      plugins = with pkgs.vimPlugins; [
        # autocomplete
        nvim-cmp
        cmp-buffer
        cmp-path
        cmp-cmdline

        #lsp
        nvim-lspconfig
        cmp-nvim-lsp

        # conform formatting
        conform-nvim

        # markdown
        # markdown-preview

        # oil FS
        oil-nvim
        nvim-web-devicons

        # treesitter
        # treesitterWithGrammars
        nvim-treesitter.withAllGrammars

        # trouble
        trouble-nvim

        # telescope-nvim
        telescope-fzf-native-nvim
        telescope-nvim
        plenary-nvim

        lualine-nvim

        tabular

        vim-fugitive

        vim-surround

        vim-sneak

        undotree

        # color
        melange-nvim

        vim-tmux-navigator
      ];

      mkEntryFromDrv =
        drv:
        if pkgs.lib.isDerivation drv then
          {
            name = "${pkgs.lib.getName drv}";
            path = drv;
          }
        else
          drv;
      lazyPath = pkgs.linkFarm "lazy-plugins" (builtins.map mkEntryFromDrv plugins);
    in
    # lua
    ''
      require("config");
      require("lazy").setup({
        defaults = {
          lazy = false,
        },
        dev = {
          path = "${lazyPath}",
          patterns = { "" },
          fallback = true,
        },
        spec = {
          { import = "plugins" },
        },
        install = {
          -- Safeguard in case we forget to install a plugin with Nix
          missing = false,
        },
      });
    '';
}
