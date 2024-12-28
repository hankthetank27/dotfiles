#!/bin/bash

# Create symlinks for dotfiles

RED='\033[0;31m'
GREEN='\033[1;32m'
YELLOW='\033[0;35m'
NO_COLOR='\033[0m'

OS=$(uname)
SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
FONT_DIR="$SCRIPT_DIR/assets/fonts"

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
    installed_message $src $dest
}

installed_message() {
    local src="$1"
    local dest="$2"
    echo -e "${GREEN}Installed ${NO_COLOR}$src ${GREEN}---> ${NO_COLOR}$dest"
}

file_exists_message() {
    local src="$1"
    echo -e "${YELLOW}Skipping ${NO_COLOR}$src${YELLOW} - already exists"
}

install_symlink() {
    local src="$1"
    local dest="$2"
    local overwrite="$3"

    if [ -d "$src" ]; then
        local name=$(get_name "$src")
        local dest_dir="${dest%/}/${name}" # Ensure no trailing slash on dest, append name

        if ! file_exists "$dest_dir" || [ "$overwrite" == "overwrite" ]; then
            link_paths "$src" "$dest_dir"
        else
            file_exists_message "$src" "$des_dir"
        fi
    elif [ -f "$src" ]; then
        if ! file_exists "$dest" || [ "$overwrite" == "overwrite" ]; then
            link_paths "$src" "$dest"
        else
            file_exists_message "$src" "$dest"
        fi
    else
        echo -e "${RED}$src is not a valid file or directory"
    fi
}

install_font() {
    local src="$1"
    local dest="$2"
    local overwrite="$3"
    local filename=$(basename "$src")
    if [ -f "$dest/$filename" ] && [ "$overwrite" != "overwrite" ]; then
        file_exists_message "$filename"
    else
        cp "$src" "$dest/"
        installed_message "$src" "$dest"
    fi
}

install_fonts_mac() {
    local overwrite="$1"
    local dest_dir="$HOME/Library/Fonts"
    mkdir -p "$dest_dir"
    for font in "$FONT_DIR"/*; do
        install_font "$font" "$dest_dir" "$overwrite"
    done
}

install_fonts_linux() {
    local overwrite="$1"
    local dest_dir="$HOME/.local/share/fonts"
    mkdir -p "$dest_dir"
    for font in "$FONT_DIR"/*; do
        install_font "$font" "$dest_dir" "$overwrite"
    done
    fc-cache -f -v
}


# Check for "overwrite" option
overwrite_flag=""
if [[ "$1" == "--overwrite" || "$1" == "-o" ]]; then
    read -p "Are you sure you want to overwrite your existing configurations? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        overwrite_flag="overwrite";
    else
        exit 0;
    fi
fi

# editor
install_symlink "$SCRIPT_DIR/editor/nvim/" "$HOME/.config/" "$overwrite_flag"
install_symlink "$SCRIPT_DIR/editor/.vimrc" "$HOME/.vimrc" "$overwrite_flag"
install_symlink "$SCRIPT_DIR/editor/zed/keymap.json" "$HOME/.config/zed/keymap.json" "$overwrite_flag"
install_symlink "$SCRIPT_DIR/editor/zed/settings.json" "$HOME/.config/zed/settings.json" "$overwrite_flag"

# home/shell
install_symlink "$SCRIPT_DIR/home/.tmux.conf" "$HOME/.tmux.conf" "$overwrite_flag"
install_symlink "$SCRIPT_DIR/home/.bashrc" "$HOME/.bashrc" "$overwrite_flag"
install_symlink "$SCRIPT_DIR/home/.inputrc" "$HOME/.inputrc" "$overwrite_flag"
install_symlink "$SCRIPT_DIR/home/.bash_aliases" "$HOME/.bash_aliases" "$overwrite_flag"
install_symlink "$SCRIPT_DIR/home/.gitconfig" "$HOME/.gitconfig" "$overwrite_flag"
install_symlink "$SCRIPT_DIR/home/kitty/" "$HOME/.config/" "$overwrite_flag"
if [ "$OS" = "Darwin" ]; then
    install_symlink "$SCRIPT_DIR/home/yabai/" "$HOME/.config/" "$overwrite_flag"
    install_symlink "$SCRIPT_DIR/home/skhd/" "$HOME/.config/" "$overwrite_flag"
fi

# bin
install_symlink "$SCRIPT_DIR/bin/tde.sh" "$HOME/.local/bin/tde" "$overwrite_flag"

# assets
if [ "$OS" = "Darwin" ]; then
    install_fonts_mac "$overwrite_flag"
elif [ "$OS" = "Linux" ]; then
    install_fonts_linux "$overwrite_flag"
else
    echo "${RED}Could not install fonts. Unsupported operating system."
fi

echo -e "${GREEN}Installation complete."

