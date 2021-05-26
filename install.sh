#!/bin/bash

BASE=$(pwd)
COLOR_GRAY="\033[1;38;5;243m"
COLOR_BLUE="\033[1;34m"
COLOR_GREEN="\033[1;32m"
COLOR_RED="\033[1;31m"
COLOR_PURPLE="\033[1;35m"
COLOR_NONE="\033[0m"

title() {
	echo -e "\n${COLOR_PURPLE}📍 $1${COLOR_NONE}"
	echo -e "${COLOR_GRAY}=================================${COLOR_NONE}\n"
}

info() {
	echo -e "${COLOR_BLUE}💁 Info: ${COLOR_NONE}$1"
}

error() {
	echo -e "${COLOR_RED}❌ Error: ${COLOR_NONE}$1"
	exit 1
}

warning() {
		echo -e "${COLOR_RED}⚠ Warning: ${COLOR_NONE}$1"
	}

success() {
	echo -e "${COLOR_GREEN}✅ $1${COLOR_NONE}"
}

set_symlink() {
	title "Create symlink and backup dir"

	CONFIG_FILES=("vimrc" "zshrc" "tmux.conf" "gitconfig")
	mkdir -pv bak
	for file in "${CONFIG_FILES[@]}"; do
		if [ -e ~/."$file" ]; then
			info "Backup $file"
			mv -v ~/."$file" bak/."$file"
		fi
		ln -sfv "$BASE/$file" ~/."$file"
	done
}

set_brew() {
	if [ ! "$(command -v brew)" ]; then
		info "Installing Homebrew"
		if [ "$(uname -s)" = "Darwin" ]; then
			# if is cluster use this- rm -rf $HOME/.brew && git clone --depth=1 https://github.com/Homebrew/brew $HOME/.brew && echo 'export PATH=$HOME/.brew/bin:$PATH' >> $HOME/.zshrc && source $HOME/.zshrc
			ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
		fi
		else if [ "$(uname -s)" = "Linux" ]; then
			/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
		fi
	fi

	info "Updating homebrew"
	brew update
	brew install tmux neovim node yarn llvm
}

set_zsh() {
	title "Installing oh-my-zsh"
	# ohmyzsh
	[ -e ~/.oh-my-zsh ] ||
		sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}

set_vim() {
	title "Setting up vim"
	# vim-plug
	mkdir -p ~/.vim/autoload
	if [ ! -e ~/.vim/autoload/plug.vim ]; then
		info "Installing vim-plug"
		curl -fLo ~/.vim/autoload/plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	fi

	# nvim
	if [ "$(command -v nvim)" ]; then
		info "Setting up neovim"

		CONFIG_FILES=( "$HOME/.config/nvim/init.vim:$BASE/vimrc"
			"$HOME/.config/nvim/coc-settings.json:$BASE/coc-settings.json"
			"$HOME/.config/nvim/autoload/plug.vim:$HOME/.vim/autoload/plug.vim" )
		mkdir -p "$HOME/.config/nvim/autoload"
		mkdir -pv "backup"
		for arr in "${CONFIG_FILES[@]}"; do
			DEST="${arr%%:*}"
			SOURCE="${arr##*:}"
			if [ -e "${DEST}" ]; then
				info "Backup ${DEST}"
				mv -v "${DEST}" "backup/$(basename ${DEST})"
			fi
			ln -sfv "${SOURCE}" "${DEST}"
		done
		nvim +PlugInstall +qall
	else
		warning "neovim not found"
		vim +PlugInstall +qall
	fi
}

case "$1" in
	all)
		set_symlink
		set_brew
		set_zsh
		set_vim
		;;
	rc)
		set_symlink
		;;
	vim)
		set_symlink
		set_vim
		;;
	brew)
		set_brew
		;;
	*)
		echo -e "Usage: ./$(basename "$0") { all | rc | vim | brew }"
		exit 1
		;;
esac

echo -e
success "Done."
