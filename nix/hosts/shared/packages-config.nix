{
  pkgs,
  fenix,
  system,
}:

with pkgs;
[
  vim
  tmux

  git
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
  unzip

  gcc

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

  # rust toolchain
  (fenix.packages.${system}.stable.withComponents [
    # nightly -- (fenix.packages.${system}.complete.withComponents [
    "cargo"
    "clippy"
    "rust-src"
    "rustc"
  ])

  #lsp
  rust-analyzer-nightly
  typescript-language-server
  nil
  lua-language-server
  bash-language-server

  #fmt
  stylua
  (fenix.packages.${system}.stable.withComponents [
    # nightly -- (fenix.packages.${system}.complete.withComponents [
    "rustfmt"
  ])
  nixfmt-rfc-style
]
