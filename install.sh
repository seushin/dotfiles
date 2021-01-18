#!/bin/bash
# ref : https://github.com/junegunn/dotfiles/blob/master/install

cd "$(dirname "${BASH_SOURCE[0]}")" || exit 1

BASE=$(pwd)
for rc in *rc tmux.conf gitconfig; do
	mkdir -pv bak
	[ -e ~/."$rc" ] && mv -v ~/."$rc" bak/."$rc"
	ln -sfv "$BASE/$rc" ~/."$rc"
done

if [ "$(uname -s)" = "Darwin" ]; then
	# Homebrew
	[ -z "$(which brew)" ] &&
		ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

	echo "Updating homebrew"
	brew install tmux neovim
fi

# ohmyzsh
[ -e ~/.oh-my-zsh ] || sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
brew install romkatv/powerlevel10k/powerlevel10k
echo "source $(brew --prefix)/opt/powerlevel10k/powerlevel10k.zsh-theme" >>~/.zshrc

git config --global user.email "seushin@student.42seoul.kr"
git config --global user.name "seushin"

# install-vim
cd $(dirname $BASH_SOURCE)
BASE=$(pwd)

# vim-plug
mkdir -p ~/.vim/autoload
[ -e ~/.vim/autoload/plug.vim ] || curl -fLo ~/.vim/autoload/plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
ln -sf $BASE/.ycm_extra_conf.py ~/.vim/

# vimrc
mv -v ~/.vimrc ~/.vimrc.old 2> /dev/null
ln -sf $BASE/vimrc ~/.vimrc

# nvim
mkdir -p ~/.config/nvim/autoload
ln -sf $BASE/vimrc ~/.config/nvim/init.vim
ln -sf ~/.vim/autoload/plug.vim ~/.config/nvim/autoload/

vim +PlugInstall +qall
