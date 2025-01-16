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
  (
    with fenix.packages.${system};
    combine [
      # nightly -- (fenix.packages.${system}.complete.withComponents [
      stable.cargo
      stable.clippy
      stable.rust-src
      stable.rustc
      targets.aarch64-unknown-linux-gnu.stable.rust-std
      targets.x86_64-unknown-linux-gnu.stable.rust-std
    ]
  )

  # (
  #   with fenix.packages.${system};
  #   combine [
  #     # nightly -- (fenix.packages.${system}.complete.withComponents [
  #     stable.cargo
  #     stable.rustc
  #     targets.aarch64-unknown-linux-gnu.stable.rust-std
  #   ]
  # )

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
