if [ "$(command -v nvim)" ]; then
	export EDITOR="nvim"
else
	export EDITOR="vi"
fi

# cluster
if [ -e "$HOME/.brew" ]; then
	export PATH="$HOME/.brew/bin:/Users/seushin/.brew/opt/llvm/bin/:$PATH"
else
	export PATH="/usr/local/opt/llvm/bin:$PATH"
fi
if [ -e "$HOME/42toolbox" ]; then
	source $HOME/42toolbox/shell_utils.sh
fi

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border \
	--preview 'bat --color=always --theme=gruvbox-dark --style=numbers --line-range=:300 {}'"

# zsh-syntax-highlighting
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

alias .='cd ..'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias cd.='cd ..'
alias cd..='cd ..'
alias l='ls -alF'
alias ll='ls -l'
alias vi=$EDITOR
alias vim=$EDITOR
alias which='type -p'
alias gv='vim +GV +"autocmd BufWipeout <buffer> qall"'
alias norm='~/.norminette/norminette.rb'
alias norm3='docker run --rm -v $PWD:/code:ro --name norminette norminette'

# apple silicon
alias brew='arch -x86_64 /usr/local/bin/brew'
alias cat='bat --theme=gruvbox-dark'
