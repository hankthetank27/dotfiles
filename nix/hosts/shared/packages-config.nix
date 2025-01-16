{
  pkgs,
  fenix,
  system,
}:
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
    cargoHash = "sha256-ptl3iGKcJf3EMyxQNdgkE/TYd3o8lfJKfcqVjyHSFCE=";
  };
in
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
  patchelf
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
  cargo-cross

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
