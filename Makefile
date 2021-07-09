help:
	@echo "$$(grep -hE '^\S+:.*##' $(MAKEFILE_LIST) | sed -e 's/:.*##\s*/:/' -e 's/^\(.\+\):\(.*\)/\\033[36m\1\\033[m:\2/' | column -c2 -t -s :)"

all: link tool ## make symlinks & install packages

link: export CONFIG_HOME := $(CONFIG_HOME)
link: ## link .config dir
	@echo "Installing dotfiles..."
	@./install/link_dirs.sh

tool: ## install packages
	@echo "Installing packages..."
	@./install/install_tools.sh
