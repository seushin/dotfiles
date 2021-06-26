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

	CONFIG_FILES=("zshrc" "tmux.conf" "gitconfig")
	mkdir -pv backup
	for file in "${CONFIG_FILES[@]}"; do
		if [ -e ~/."$file" ]; then
			info "Backup $file"
			mv -v ~/."$file" backup/."$file"
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
	if [ ! -e ~/.oh-my-zsh ]; then
		sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
	fi
	brew install bat zsh-syntax-highlighting
	npm i -g git-split-diff
	mkdir -p "$HOME/.config/zsh"
	ln -sfv "${BASE}/.config/zsh/.zshenv" "${HOME}/.config/zsh/.zshenv"
}

set_vim() {
	title "Setting up vim"

	if [ "$(command -v nvim)" ]; then
		info "Setting up neovim"

		mkdir -p "$HOME/.config"
		mkdir -pv "backup"
		DEST="${HOME}/.config/nvim"
		SOURCE="${BASE}/config/nvim"
		if [ -e "${DEST}" ]; then
			info "Backup ${DEST}"
			mv -v "${DEST}" "backup/$(basename ${DEST})"
		fi
		ln -sfv "${SOURCE}" "${DEST}"
		nvim +PlugInstall +qall
	else
		warning "neovim not found"

		ln -sfv "${BASE}/config/nvim/autoload" "${HOME}/.vim/autoload"
		ln -sfv "${BASE}/config/nvim/init.vim" "${HOME}/.vimrc"
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
