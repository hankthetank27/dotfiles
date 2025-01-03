{ pkgs, fenix, system }:

with pkgs; [
  docker
  docker-compose

  vim
  neovim
  tmux

  htop
  flyctl
  coreutils
  ffmpeg
  bash-completion
  ripgrep 
  jq
  tree-sitter
  shopify-cli
  hugo
  cmake
  wget
  openssl
  openssl_3

  sqlite
  mongosh

  rbenv
  ruby_3_1

  zig_0_12

  lua

  erlang
  elixir_1_18

  python313
  virtualenv

  nodePackages.npm # globally install npm
  nodePackages.prettier
  nodejs_23
  # nodejs

  # rust toolchain //
  # lets try the macos pkg way on linux and see if we can use that as shared
  # (fenix.complete.withComponents [
  #   "cargo"
  #   "clippy"
  #   "rust-src"
  #   "rustc"
  #   "rustfmt"
  # ])
  rust-analyzer-nightly
]
