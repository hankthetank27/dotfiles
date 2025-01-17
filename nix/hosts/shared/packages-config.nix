{
  pkgs,
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
  (rust-bin.stable.latest.default.override {
    extensions = [
      "rust-src"
      "rust-analyzer"
      "rustfmt"
    ];
    targets = [
      "aarch64-unknown-linux-gnu"
      "x86_64-unknown-linux-gnu"
      "aarch64-apple-darwin"
      "x86_64-apple-darwin"
      "x86_64-pc-windows-gnu"
    ];
  })
  cargo-cross

  #lsp
  typescript-language-server
  nil
  lua-language-server
  bash-language-server

  #fmt
  stylua
  nixfmt-rfc-style
]
