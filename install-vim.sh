#!/bin/bash

cd $(dirname $BASH_SOURCE)
BASE=$(pwd)

# vim-plug
mkdir -p ~/.vim/autoload
[ -e ~/.vim/autoload/plug.vim ] ||
	curl -fLo ~/.vim/autoload/plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# vimrc
mv -v ~/.vimrc ~/.vimrc.old 2> /dev/null
ln -sf $BASE/vimrc ~/.vimrc

# nvim
mkdir -p ~/.config/nvim/autoload
ln -sf $BASE/vimrc ~/.config/nvim/init.vim
ln -sf ~/.vim/autoload/plug.vim ~/.config/nvim/autoload/

vim +PlugInstall +qall
