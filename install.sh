#!/bin/bash

# create symlinks for dotfiles

get_name(){
    if [ ${1: -1} = "/" ]; then
        del_last=${1:: -1}
        echo ${del_last##*/}
    else
        echo ${1##*/}
    fi
}

file_exists(){
    if [ ! -e $1  ] || [ ! -L $1 ]; then
        false 
    else
        true
    fi
}

make_link(){
    dest=$1
    src=$2
    if [ -d $dest ]; then
        name=$(get_name $dest)
        src_dir=$src$name
        if [ ${src: -1} != "/" ]; then
            src_dir="$src/$name"
        fi
        if ! file_exists $src_dir; then
            ln -s $dest $src
            echo "$dest ---> $src"
        fi
    elif [ -f $dest ]; then
        if ! file_exists $src; then
            ln -s $dest $src
            echo "$dest ---> $src"
        fi
    else
        echo "$dest: is not a valid file or directory" 
    fi
}

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# tmux
make_link $SCRIPT_DIR/tmux/.tmux.conf $HOME/.tmux.conf

# vim
make_link $SCRIPT_DIR/.vimrc $HOME/.vimrc

# nvim
make_link $SCRIPT_DIR/nvim/ $HOME/.config/

#bin
make_link $SCRIPT_DIR/bin/tde.sh $HOME/.local/bin/tde

#other
make_link $SCRIPT_DIR/.inputrc $HOME/.inputrc
