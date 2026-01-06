move_and_symlink () 
{ 
    mv "$(pwd)/$1" "/home/cobbn/dotfiles" && ln -s "/home/cobbn/dotfiles/$1" "$(pwd)/$1"
}

eval "$(/home/cobbn/.local/bin/oh-my-posh init bash --config catppuccin)"
