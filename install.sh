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
	brew install tmux neovim node yarn llvm
fi

# ohmyzsh
[ -e ~/.oh-my-zsh ] || sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
brew install romkatv/powerlevel10k/powerlevel10k
echo "source $(brew --prefix)/opt/powerlevel10k/powerlevel10k.zsh-theme" >>~/.zshrc

git config --global user.email "seushin@student.42seoul.kr"
git config --global user.name "seushin"

./install-vim.sh
