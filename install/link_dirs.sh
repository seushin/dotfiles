#!/bin/bash

set -x

BASE=$(pwd)
CONFIG_HOME=$(HOME)/.config/

if [[ -e $HOME/.zshenv ]]; then
	mv $HOME/.zshenv $HOME/.zshenv_backup
fi

if [[ -d $CONFIG_HOME ]]; then
	mv $CONFIG_HOME $HOME/.config_backup
fi

ln -sf $BASE/.zshenv $HOME/.zshenv
ln -sf $BASE/config $CONFIG_HOME
