# Install instructions

(assuming the directory `.vim` does not exist in the home directory)

    cd # goto home directory
    git clone --recursive https://github.com/ThomasFeher/Vim.git .vim
    vim +PluginInstall +qall # make Vundle install all plugins
    # compile YouCompleteMe
    cd .vim/bundle/YouCompleteMe
    ./install.sh --clang-completer # see YouCompleteMe documentation for all possible configurations
    cd # goto home directory
