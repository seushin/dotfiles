# cluster
if [ -e "$HOME/.brew" ]; then
	export PATH="$HOME/.brew/bin:$HOME/.brew/opt/llvm/bin/:$PATH"
else
	export PATH="/usr/local/opt/llvm/bin:$PATH"
fi
if [ -e "$HOME/42toolbox" ]; then
	source $HOME/42toolbox/shell_utils.sh
fi

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border"

source "$HOME/.config/zsh/z.sh"
unalias z 2> /dev/null
z() {
  [ $# -gt 0 ] && _z "$*" && return
  cd "$(_z -l 2>&1 | sed 's/^[0-9,.]* *//' | fzf --height 40% --nth 1.. --reverse --tac --query "${*##-* }")"
}

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completio
