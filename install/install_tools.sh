#!/bin/bash

set -x

if [ ! "$(command -v brew)" ]; then
	if [ "$(uname -s)" = "Darwin" ]; then
		# if is cluster use this- rm -rf $HOME/.brew && git clone --depth=1 https://github.com/Homebrew/brew $HOME/.brew && echo 'export PATH=$HOME/.brew/bin:$PATH' >> $HOME/.zshrc && source $HOME/.zshrc
		ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	elif [ "$(uname -s)" = "Linux" ]; then
		/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
		echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> ./config/zsh/include/tools.zsh
		eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
	fi
fi

if [ ! -e ~/.oh-my-zsh ]; then
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi
if [ "$(command -v brew)" ]; then
	brew install tmux neovim node yarn llvm bat zsh-syntax-highlighting pure
fi
if [ "$(command -v npm)" ]; then
	npm i -g git-split-diffs git-amend
fi
