#!/bin/bash

# Create symlinks for dotfiles

RED='\033[0;31m'
GREEN='\033[1;32m'
YELLOW='\033[0;35m'
NO_COLOR='\033[0m'

get_name() {
  local filepath="$1"
  filepath="${filepath%/}" # Remove trailing slash if present
  echo "${filepath##*/}" # Extract the file name
}

file_exists() {
  [ -e "$1" ] || [ -L "$1" ] # Check if file or symlink exists
}

link_paths() {
  local src="$1"
  local dest="$2"
  ln -sfn "$src" "$dest"
  echo -e "${GREEN}Linked paths ${NO_COLOR}$src ${GREEN}---> ${NO_COLOR}$dest"
}

file_exists_message() {
  local path="$1"
  local path_type="$2"
  echo -e "${YELLOW}$path_type already exists at destination${NO_COLOR} $dest"
}

make_link() {
  local src="$1"
  local dest="$2"
  local force="$3"
  
  if [ -d "$src" ]; then
    local name=$(get_name "$src")
    local dest_dir="${dest%/}/${name}" # Ensure no trailing slash on dest, append name
    
    if ! file_exists "$dest_dir" || [ "$force" == "force" ]; then
      link_paths "$src" "$dest_dir"
    else
      file_exists_message "$dest_dir" "Directory"
    fi
  elif [ -f "$src" ]; then
    if ! file_exists "$dest" || [ "$force" == "force" ]; then
      link_paths "$src" "$dest"
    else
      file_exists_message "$dest_dir" "File"
    fi
  else
    echo -e "${RED}$src is not a valid file or directory"
  fi
}

# Check for "force" option
force_flag=""
if [[ "$1" == "force" ]]; then
  force_flag="force"
fi

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)

# editor
make_link "$SCRIPT_DIR/editor/nvim/" "$HOME/.config/" "$force_flag"
make_link "$SCRIPT_DIR/editor/.vimrc" "$HOME/.vimrc" "$force_flag"
make_link "$SCRIPT_DIR/editor/zed/keymap.json" "$HOME/.config/zed/keymap.json" "$force_flag"
make_link "$SCRIPT_DIR/editor/zed/settings.json" "$HOME/.config/zed/settings.json" "$force_flag"

# home/shell
make_link "$SCRIPT_DIR/home/.tmux.conf" "$HOME/.tmux.conf" "$force_flag"
make_link "$SCRIPT_DIR/home/.bashrc" "$HOME/.bashrc" "$force_flag"
make_link "$SCRIPT_DIR/home/.inputrc" "$HOME/.inputrc" "$force_flag"
make_link "$SCRIPT_DIR/home/.bash_aliases" "$HOME/.bash_aliases" "$force_flag"
make_link "$SCRIPT_DIR/home/.gitconfig" "$HOME/.gitconfig" "$force_flag"
make_link "$SCRIPT_DIR/home/kitty/" "$HOME/.config/" "$force_flag"

# bin
make_link "$SCRIPT_DIR/bin/tde.sh" "$HOME/.local/bin/tde" "$force_flag"

# assets
FONT_DIR="$SCRIPT_DIR/assets/fonts"
OS=$(uname)

install_font() {
    local src="$1"
    local dest="$2"
    local filename=$(basename "$src")
    if [ -f "$dest/$filename" ]; then
        echo "Skipping $filename - already exists"
    else
        cp "$src" "$dest/"
        echo "Installed $filename"
    fi
}

install_fonts_mac() {
    local dest_dir="$HOME/Library/Fonts"
    mkdir -p "$dest_dir"
    for font in "$FONT_DIR"/*; do
        install_font "$font" "$dest_dir"
    done
}

install_fonts_linux() {
    local dest_dir="$HOME/.local/share/fonts"
    mkdir -p "$dest_dir"
    for font in "$FONT_DIR"/*; do
        install_font "$font" "$dest_dir"
    done
    fc-cache -f -v
}

if [ "$OS" = "Darwin" ]; then
    install_fonts_mac
elif [ "$OS" = "Linux" ]; then
    install_fonts_linux
else
    echo "Unsupported operating system"
fi

echo -e "${GREEN}Installation complete"

