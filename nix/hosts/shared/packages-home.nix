{ pkgs }:
with pkgs;
let
  cargo-cross = pkgs.rustPlatform.buildRustPackage {
    pname = "cross";
    version = "0.2.5-nightly";
    doCheck = false;
    src = pkgs.fetchFromGitHub {
      owner = "cross-rs";
      repo = "cross";
      rev = "4090beca3cfffa44371a5bba524de3a578aa46c3";
      sha256 = "sha256-5wC8n6Akucs1T44BxHOO5wl19BnrTGgwD+tymxsBMik=";
    };
    cargoHash = "sha256-8a9SJuz16MUYz8ePVtXwl0dmtjrCvZabTZwiwz45/PQ=";
  };
in
[
  # general utils
  coreutils
  htop
  ffmpeg
  id3v2
  flac
  bash-completion
  ripgrep
  jq
  tree-sitter
  wget
  curl
  patchelf
  unzip
  unrar
  xz
  sops

  # db
  sqlite
  postgresql
  mongosh

  # devops-ish stuff
  flyctl
  google-cloud-sdk

  # language toolchains etc
  cmake

  rustup
  cargo-cross
  cargo-udeps

  nodePackages.npm # globally install npm
  nodePackages.prettier
  nodejs
  corepack
  yarn
  # deno

  # ruby
  # rbenv

  zig

  lua

  go
  gotools

  elixir

  python313
  virtualenv

  hugo

  shopify-cli

  #nix
  nix-output-monitor # get additional information while building packages
  nix-tree # interactively browse dependency graphs of Nix derivations
  nix-update # swiss-knife for updating nix packages

  #lsp
  # rust-analyzer
  elixir-ls
  typescript-language-server
  nil
  lua-language-server
  bash-language-server

  #fmt
  stylua
  nixfmt-rfc-style

  # font
  inconsolata
  nerd-fonts.inconsolata
]
