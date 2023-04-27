#!/bin/bash

DIR=$HOME/dotfiles

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
    dest=$DIR$1
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

make_link /.tmux.conf ~/.tmux.conf
make_link /.config/nvim/ ~/.config/
make_link /bin/tat ~/.local/bin/tat
