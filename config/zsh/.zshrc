# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME=""

if [ "$(command -v nvim)" ]; then
	export EDITOR="nvim"
else
	export EDITOR="vi"
fi

source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $ZSH/oh-my-zsh.sh

include=(
	'aliases'
	'tools'
)

for i in "${include[@]}"; do
	source $ZDOTDIR/include/$i.zsh
done

autoload -U promptinit; promptinit
prompt pure
