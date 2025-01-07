_:

{
  # Building this configuration will create a copy of 'dotfiles/screenrc' in
  # the Nix store. Activating the configuration will then make '~/.screenrc' a
  # symlink to the Nix store copy.

  # editor
  # "./.config/nvim".source =  ../../../editor/nvim;
  "./.vimrc".source = ../../../editor/.vimrc;
  "./.config/zed/keymap.json".source = ../../../editor/zed/keymap.json;
  "./.config/zed/settings.json".source = ../../../editor/zed/settings.json;

  # home/shell
  "./.tmux.conf".source = ../../../home/.tmux.conf;
  "./.bashrc".source = ../../../home/.bashrc;
  "./.inputrc".source = ../../../home/.inputrc;
  "./.bash_aliases".source = ../../../home/.bash_aliases;
  "./.gitconfig".source = ../../../home/.gitconfig;
  "./.config/kitty".source = ../../../home/kitty;

  # bin
  "./.local/bin/tde".source = ../../../bin/tde.sh;

  #assets
}
