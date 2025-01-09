{ pkgs, ... }:
with pkgs;
let
  tabline = pkgs.stdenv.mkDerivation {
    name = "tabline.vim";
    src = fetchFromGitHub {
      owner = "mkitt";
      repo = "tabline.vim";
      rev = "69c9698a3240860adaba93615f44778a9ab724b4";
      sha256 = "1dk796zacs0x9kfr15db9j7034w6fqhng9pr49g1ga4a3hzzqmp7";
    };
    installPhase = ''
      mkdir -p $out/share/vim-plugins/tabline
      cp -r * $out/share/vim-plugins/tabline
    '';
  };
in

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
        markdown-preview-nvim

        # oil FS
        oil-nvim
        nvim-web-devicons

        # treesitter
        nvim-treesitter.withAllGrammars

        # trouble
        trouble-nvim

        # telescope-nvim
        telescope-fzf-native-nvim
        telescope-nvim
        plenary-nvim

        lualine-nvim

        tabline

        tabular

        vim-fugitive

        vim-surround

        vim-repeat

        vim-commentary

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
