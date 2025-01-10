_:

{
  # Building this configuration will create a copy of 'dotfiles/screenrc' in
  # the Nix store. Activating the configuration will then make '~/.screenrc' a
  # symlink to the Nix store copy.

  # editor
  "./.vimrc".source = ../../../editor/.vimrc;
  "./.config/zed/keymap.json".source = ../../../editor/zed/keymap.json;
  "./.config/zed/settings.json".source = ../../../editor/zed/settings.json;

  # home/shell
  "./.inputrc".source = ../../../home/.inputrc;
  "./.bash_aliases".source = ../../../home/.bash_aliases;
  "./.gitconfig".source = ../../../home/.gitconfig;
  "./.config/kitty".source = ../../../home/kitty;
}
