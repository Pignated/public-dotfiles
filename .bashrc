move_and_symlink () 
{ 
    mv "$(pwd)/$1" "/home/cobbn/dotfiles" && ln -s "/home/cobbn/dotfiles/$1" "$(pwd)/$1"
}
eval "$(direnv hook bash)"
export EDITOR="nvim"
export VISUAL="nvim"
export SUDO_EDITOR="nvim"
eval "$(/home/cobbn/.local/bin/oh-my-posh init bash --config catppuccin)"
alias term_here="(nohup kitty > /dev/null 2>&1 &)"
alias re-source="source ~/.bashrc"
